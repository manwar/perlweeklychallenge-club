#!/usr/bin/env julia

#=

AUTHOR: Robert DiCicco

DATE  : 2022-12-26

Challenge 197 Move Zero ( Julia )

=#

using Printf

 

lists = [[1, 0, 3, 0, 0, 5],[1, 6, 4],[0, 1, 0, 2, 0]]

 

for list in lists

                i = 1

                left  = Int64[]

                right = Int64[]

                @printf("Input: @list = %s\n", list)

                while i <= length(list)

                                if list[i] > 0

                                                push!(left,list[i])

                                else

                                                push!(right, list[i])

                                end

                                i += 1

                end

                println("Output: ", cat(left,right,dims=1),"\n")

end

 

#=

-----------------------------------------------------

SAMPLE OUTPUT

julia .\MoveZero.jl

Input: @list = [1, 0, 3, 0, 0, 5]

Output: [1, 3, 5, 0, 0, 0]

 

Input: @list = [1, 6, 4]

Output: [1, 6, 4]

 

Input: @list = [0, 1, 0, 2, 0]

Output: [1, 2, 0, 0, 0]

=#
