function playon --description "playon [<user>@]<host> [[user@]<host>...] [ANSIBLE OTIONS] <playbook>"
    set ansible_args
    set ansible_inventory ""
    set ansible_playbook ""
    set expect_param false
    set python_version 3

    for arg in $argv
        switch $arg
            case '-2'
                set python_version 2
            case '-*'
                switch "$arg"
                    case --private-key --key-file \
                        --scp-extra-args --sftp-extra-args \
                        --ssh-common-args --ssh-extra-args \
                        --start-at-task --vault-id --vault-password-file \
                        --module-path \
                        -c --connection -e --extra-vars \
                        -f --forks -t --tags -u --user
                        set expect_param true
                    case -u --user
                        echo "Can't use -u, --user with this command"
                        return 1
                    case -i --inventory --inventory-file
                        echo "Can't use -i, --inventory, --inventory-file with this command"
                        return 1
                    case *
                        :
                end
                set ansible_args "$ansible_args $arg"
            case '*'
                if [ "$expect_param" = "true" ]
                    set expect_param false
                    set ansible_args "$ansible_args $arg"
                else
                    if [ -f $arg ]
                        if [ -n $ansible_playbook ]
                            echo "Not expecting multiple playbook."
                            return 1
                        end
                        set ansible_playbook $arg
                    else
                        set ansible_inventory "$ansible_inventory$arg,"
                    end
                end
        end
    end

    if [ -z $ansible_inventory ]
        echo "No valid remote host found."
        return 1
    end

    if [ -z $ansible_playbook ]
        echo "No valid playbook found."
        return 1
    end

    echo "ansible-playbook --inventory $ansible_inventory --extra-vars 'ansible_python_interpreter=/usr/bin/python$python_version' $ansible_args $ansible_playbook"
    eval "ansible-playbook --inventory $ansible_inventory --extra-vars 'ansible_python_interpreter=/usr/bin/python$python_version' $ansible_args $ansible_playbook"
end
