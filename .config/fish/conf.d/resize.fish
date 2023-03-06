if test "(type -t resize)" = "file"
	function resize --wraps=resize --inherit-variable resize
		for line in (resize | grep =)
			set item (string split -m 1 '=' $line)
			set -gx $item[1] $item[2]
		end
	end
	isatty 1 && resize
end
