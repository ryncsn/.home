# Execute a set of ansible tasks directly
function playon --description "playon [<user>@]<host> [[user@]<host>...] [ANSIBLE OTIONS] <playbook>"
    set ansible_args
    set ansible_arg_inventory ""
    set ansible_playbook_file (mktemp -p (pwd) playon.XXXXXX)
    set expect_param false
    set python_version 3

    echo -n "---
- hosts: all
  tasks:
" > $ansible_playbook_file

    for arg in $argv
        if test "$expect_param" = "true"
            set expect_param false
            set ansible_args $ansible_args $arg
        else
            switch $arg
                case '-2'
                    set python_version 2
                case '-*'
                    switch $arg
                        case --private-key --key-file \
                            --scp-extra-args --sftp-extra-args \
                            --ssh-common-args --ssh-extra-args \
                            --start-at-task --vault-id --vault-password-file \
                            --module-path \
                            -c --connection -e --extra-vars \
                            -f --forks -t --tags -u --user -i --inventory
                            set expect_param true
                    end
                    set ansible_args $ansible_args $arg
                case '*.yml' '*.yaml'
                    echo "  - name: $arg" >> $ansible_playbook_file
                    echo "    import_tasks: $arg" >> $ansible_playbook_file
                case '*'
                    if [ -f $arg ]
                        set ansible_args -i $arg
                    else
                        set ansible_arg_inventory $ansible_arg_inventory$arg,
                    end
            end
        end
    end

    if [ -n $ansible_arg_inventory ]
        set ansible_args -i "$ansible_arg_inventory" $ansible_args
    end

    echo "Temporary built playbook: "
    cat $ansible_playbook_file
    echo

    echo ansible-playbook $ansible_args --extra-vars "ansible_python_interpreter=/usr/bin/python$python_version" $ansible_playbook_file
    ansible-playbook $ansible_args --extra-vars "ansible_python_interpreter=/usr/bin/python$python_version" $ansible_playbook_file

    test -e $ansible_playbook_file && rm -f -- $ansible_playbook_file
end
