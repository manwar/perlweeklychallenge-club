#!/usr/bin/env julia
#=
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-10
Challenge 212 Jumping Letters ( Julia )
---------------------------------------
=#

using Printf

word = "Perl"
jump = [2,22,19,9]

#word = "Raku"
#jump = [24,4,7,17]

alphabet = ["a","b","c","d","e","f","g","h","i","j",
            "k","l","m","n","o","p","q","r","s","t",
            "u","v","w","x","y","z"]

@printf("Input: \$word = '%s' and @jump = %s\n", word, jump)

@printf("Output :")

for n in (1:4)
    ndx = findfirst(isequal(lowercase(SubString(word, n, n))), alphabet)
    ndx += jump[n]
    n==0 ? print(uppercase(alphabet[ndx % 26])) : print(alphabet[ndx % 26])
end

#=
---------------------------------------
SAMPLE OUTPUT
julia .\Jumping.jl
Input: $word = 'Perl' and @jump = [2, 22, 19, 9]
Output :raku

julia .\Jumping.jl
Input: $word = 'Perl' and @jump = [2, 22, 19, 9]
Output :raku
---------------------------------------
=#

