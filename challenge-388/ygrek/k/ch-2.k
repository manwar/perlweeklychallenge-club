(in;out):`i$*''(`j?1:"../../examples/json/ch-2.json").(`examples;`in`out)

p:0 0
a:1
b:1

/ p(0) = 0; p(n) = n! - p(n-1)*n - p(n-2)*n*(n-1)/2 - p(n-3)*n*(n-1)*(n-2)/2*3 - ... - 1
(5-1) {a::(#p)*a,1; b::((#p)**b),b; p::p,(*b)-1+/p*(-b)!'a}/0
out
1_p

/ subfactorial
3{x,(#x)*+/-2#x}/0 1
