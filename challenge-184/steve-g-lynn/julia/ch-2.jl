#!/usr/bin/env julia

list=("a 1 2 b 0","3 c 4 d")

#Output
#[['1', '2', '0'], ['3', '4']]
#[['a', 'b'], ['c', 'd']]


#list=("1 2", "p q r","s 3", "4 5 t")

#Output:
#[['1', '2'], ['3'], ['4', '5']]
#[['p', 'q', 'r'], ['s'], ['t']]

g_numbers=Vector{Char}[]
g_alphas=Vector{Char}[]

for string in list
    numbers=Char[]
    alphas=Char[]
    for char in split(string)
        char=only(char) #-- coerce str to char
        if char in '0':'9'
            push!(numbers,char)
         elseif char in 'a':'z'
            push!(alphas,char)
         end
    end
    if length(numbers) > 0
        push!(g_numbers,numbers)
    end
    if length(alphas) > 0
        push!(g_alphas,alphas)
    end
end

println(g_numbers)
println(g_alphas)
