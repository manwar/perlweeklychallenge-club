#!/usr/bin/env julia

using Primes
using Lazy

totientsum(x) = @>> x iterated(totient) takeuntil( ==(1) ) drop(1) sum

k = isassigned(ARGS) ? parse(Int,ARGS[1]) : 20

@>> Lazy.range(3,Inf,2) filter( x -> totientsum(x) == x) take(k) collect println
