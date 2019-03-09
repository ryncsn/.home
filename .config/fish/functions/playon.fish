function playon --description "playon [<user>@]<host> [[user@]<host>...] <playbook> [ANSIBLE OTIONS]"
    set ansible_args
    set ansible_inventory ""
    set ansible_playbook ""

    for arg in $argv
        switch $arg
            case '*@*'
                set ansible_inventory "$ansible_inventory$arg,"
            case '-*'
                set -a ansible_args "$arg"
            case '*'
                if [ -n $ansible_playbook ]
                    # Last non *@* arg is considered the playbook
                    set ansible_inventory "$ansible_inventory$ansible_playbook,"
                end
                set ansible_playbook "$arg"
        end
    end
    echo ansible-playbook --inventory $ansible_inventory --extra-vars "ansible_python_interpreter=/usr/bin/python3" $ansible_playbook $ansible_args
    ansible-playbook --inventory $ansible_inventory --extra-vars "ansible_python_interpreter=/usr/bin/python3" $ansible_playbook $ansible_args
end
