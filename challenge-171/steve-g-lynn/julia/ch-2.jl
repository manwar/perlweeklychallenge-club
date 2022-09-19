#!/usr/bin/julia

function compose(g,f)
	gof(x)=g(f(x))
	return gof
end

#-- example
f(x)=x+1
g(x)=3*x

gof=compose(g,f)

println(gof(5)) #-- 18

