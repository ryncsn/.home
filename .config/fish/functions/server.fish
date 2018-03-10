function server --description "Start an HTTP server from a directory"
    if count $argv > /dev/null
        python3 -m http.server $argv
    else
        python3 -m http.server 8080
    end
end
