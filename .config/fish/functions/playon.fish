function playon --description "playon [<user>@]<host> [[user@]<host>...] [ANSIBLE OTIONS] <playbook>"
    set ansible_args
    set ansible_inventory ""
    set ansible_playbook ""
    set args_parsed false

    for arg in $argv
        switch $arg
            case '*@*'
                set ansible_inventory "$ansible_inventory$arg,"
            case '-*'
                set ansible_args "$ansible_args $arg"
                set args_parsed true
            case '*'
                if [ -f $arg ]
                    set ansible_playbook "$arg"
                else
                    if [ $args_parsed = false ]
                        set ansible_inventory "$ansible_inventory$arg,"
                    else
                        set ansible_args "$ansible_args $arg"
                    end
                end
        end
    end
    eval "ansible-playbook --inventory $ansible_inventory --extra-vars 'ansible_python_interpreter=/usr/bin/python3' $ansible_args $ansible_playbook"
end
