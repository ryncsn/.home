function server --description "Start an HTTP server from a directory"
    if count $argv > /dev/null
        python -m SimpleHTTPServer $argv
    else
        python -m SimpleHTTPServer 8080
    end
end
