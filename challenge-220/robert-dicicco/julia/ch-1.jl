#!/usr/bin/env julia
#=
------------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-06-05
Challenge 220 Task 1 common Characters ( Julia )
------------------------------------------------
=#

using Printf

words = [["Perl", "Rust", "Raku"], ["love", "live", "leave"]]
alphabet_hash = Dict()

for wds in words
    for c in 'a':'z'
        alphabet_hash[c] = 0
    end
    @printf("Input: @words = %s\n",wds)
    for wd in wds
        for ch in lowercase(wd)
             alphabet_hash[ch] += 1
        end
    end
    @printf("Output: ")
    # Print the dictionary
    for (key, value) in alphabet_hash
        if value >= 3
            @printf("%s ",key)
        end
    end
    println("\n")
end

#=
------------------------------------------------
julia .\CommonChars.jl

Input: @words = ["Perl", "Rust", "Raku"]
Output: r

Input: @words = ["love", "live", "leave"]
Output: e v l
------------------------------------------------
=#




