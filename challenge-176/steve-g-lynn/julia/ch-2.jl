#!/usr/bin/env julia

for i in 1:100
	my_digits = digits(i+parse(Int64,reverse(string(i))))
	for digit in my_digits
		if digit % 2 == 0
			@goto next_i
		end
	end
	println(i)
	@label next_i
end

