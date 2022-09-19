#!/usr/bin/env julia

using Lazy

k = isassigned(ARGS) ? parse(Int,ARGS[1]) : 20

@>> Lazy.range() begin
    map(string)
    filter( x -> !in('0',x) )
    map( x -> x * '0' * reverse(x) )
    map(x -> parse(Int,x) )
    filter( Lazy.isprime )
    take(k)
    foreach(println)
end
