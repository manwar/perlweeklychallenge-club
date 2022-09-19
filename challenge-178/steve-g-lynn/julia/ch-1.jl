#!/usr/bin/env julia

#-- this works only for real integers
#-- uses the connection between base -4 and base 2i for reals
#-- (see wikipedia: https://en.wikipedia.org/wiki/Quater-imaginary_base)

function quater_imaginary( n::Int64) ::String
	dn = digits(n,base=-4)
	return join(reverse(dn),0)
end

println(quater_imaginary(4)) #10300
println(quater_imaginary(-15)) #1030001

