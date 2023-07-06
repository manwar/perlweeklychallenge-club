#!usr/bin/env julia
#=
----------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-04
Challenge 224 Task 1 Special Notes ( Julia )
----------------------------------------------
=#
source = ARGS[1]
target = ARGS[2]

flag = 0
offset = 1

while offset < length(target)
    global offset, flag
    letter = target[offset]
    if ! occursin(letter,source)
        println("Output: false")
        flag = -1
        break
    end
    offset += 1
end

if flag == 0
    println("Output: true")
end

#=
----------------------------------------------
julia .\SpecialNotes.jl scriptinglanguage perl
Output: true

julia .\SpecialNotes.jl abc xyz
Output: false

julia .\SpecialNotes.jl aabbcc abc
Output: true
----------------------------------------------
=#


