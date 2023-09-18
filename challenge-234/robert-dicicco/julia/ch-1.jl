#!/usr/bin/env julia
#=
------------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-13
Challenge 234 Task 1 Common Characters ( Julia )
------------------------------------------------
=#

using Printf

wordlist = [["java", "javascript", "julia"],["bella", "label", "roller"],["cool", "lock", "cook"]]

function CreateSeen(w)
    wordnum = length(w)
    charset = join(w)
    seen = Dict(map(k -> (k,0), 'a':'z'))
    for x in charset
        seen[x] += 1
    end

    @printf("Output: (")
    for (key, val) in seen
        if (val >= wordnum && val < (2*wordnum))
            @printf("%s ",key)
        elseif (val == (2*wordnum))
            @printf("%s %s ",key,key)
        end
    end
    println(")\n")
end

for wds in wordlist
    @printf("Input: %s\n",wds)
    charset = ""
    CreateSeen(wds)
end
