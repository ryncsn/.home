if type -q grc
	if test -f /opt/homebrew/etc/grc.fish
		source /opt/homebrew/etc/grc.fish
	end

	# Fix ls color issue with grc
	function ls --wraps=ls
		if isatty 1
			grc ls --color=always $argv
		else
			eval ls $argv
		end
	end
end
