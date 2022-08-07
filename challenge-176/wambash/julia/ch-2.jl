#!/usr/bin/env julia

using Lazy

is_reversible(n) = @>> begin
    n
    string
    reverse
    parse(Int)
    +(n)
    digits
    all( isodd )
end

maxv = isassigned(ARGS) ? parse(Int,ARGS[1]) : 100

@>> Lazy.range() filter(is_reversible) takewhile(<(maxv)) partition(16 ,pad=list() ) map( x->join(x," ") ) foreach(println)

using Test

@test  is_reversible(    14)
@test !is_reversible(   144)
@test  is_reversible(   748)
@test  is_reversible(123456)
@test !is_reversible( 12345)
