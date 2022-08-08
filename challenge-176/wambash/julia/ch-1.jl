#!/usr/bin/env julia

using Lazy

is_permuted_multiple(n) = @>> n * [2,3,4,5,6] map(digits) map(sort) all( ==(@> n digits sort) )

max_digits = isassigned(ARGS) ? parse(Int,ARGS[1]) : 6

@>> begin
    Lazy.range()
    map( x -> Lazy.range(10^x,div(10^(x+1),6)) )
    map( x -> filter(is_permuted_multiple,x))
    take(max_digits-1)
    reduce(*)
    foreach(println)
end

using Test
@test  is_permuted_multiple(142857)
@test !is_permuted_multiple(142587)
