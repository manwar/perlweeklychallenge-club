#!/usr/bin/env julia
#=
------------------------------------------
AUTHOR: Robert DiCicco
DATE  ; 2023-03-21
Challenge 209 Special Bit Chars ( Julia )
------------------------------------------
=#
using Printf

bits = [[1, 0, 0],[1, 1, 1, 0]]
ln = length(bits)

lastchar = ' '
flag = 0
for sub in bits
    global lastchar
    global flag
    @printf("Input: @bits = %s\n", sub)
    ref_len = length(sub)
    #flag = 0
    for x in (1:ref_len)
        if sub[x] == 1
            if flag == 0
                flag = 1
            else
                @printf("%s",'c')
                lastchar = 'c'
                flag = 0
            end
        elseif sub[x] == 0
            if flag == 0
                @printf("%s",'a')
                lastchar = 'a'
            elseif flag == 1
                @printf("%s",'b')
                lastchar = 'b'
                flag = 0
            end
        end
    end
    println(" ")
    if (lastchar == 'a') && (flag == 0)
        println("Output: 1")
    else
        println("Output: 0")
    end
    println(" ")
end
#=
------------------------------------------
SAMPLE OUTPUT
julia .\SpecialBit.jl
Input: @bits = [1, 0, 0]
ba
Output: 1

Input: @bits = [1, 1, 1, 0]
cb
Output: 0
------------------------------------------
=#
