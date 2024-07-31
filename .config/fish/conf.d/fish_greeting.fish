function fish_greeting
	if command --search fortune >/dev/null do
		fortune
	end
end
