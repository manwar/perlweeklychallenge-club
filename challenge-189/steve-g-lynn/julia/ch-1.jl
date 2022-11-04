#!/usr/bin/env julia

function greater_character( target::Char, arry::Vector{Char} ) ::Char
    arry=sort(arry)
    for i in arry
        if (i > target)
            return i
        end
    end
    return target
end

println(greater_character('b',['e','m','u','g'])) #e
println(greater_character('a',['d','c','e','f'])) #c
println(greater_character('o',['j','a','r'])) #r
println(greater_character('a',['d','c','a','f'])) #c
println(greater_character('v',['t','g','a','l'])) #v

