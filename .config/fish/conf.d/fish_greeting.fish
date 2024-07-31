function fish_greeting
	if command --search fortune >/dev/null do
		if command --search cowsay >/dev/null do
			fortune | cowsay
		else
			fortune
		end
	end
end
