#!/usr/bin/env julia

#=

AUTHOR: Robert DiCicco

DATE:   01-18-2023

Challenge #200 Arithmetic Slices ( Julia )

=#

using Printf

 

lists = [[1,2,3,4],[2]]

out = []

 

function GetIntervals(slice)

                if length(slice) < 3

                                return -1

                end

                x = 1

               

                while x < length(slice)

                                if x > 1

                                                interval = slice[x] - slice[x-1]

                                                push!(out, interval)

                                end

                                x += 1

                end

                testval = out[1]

                for arrint in out

                                if arrint != testval

                                                return -1

                                end

                end

                return 1

end

 

for list in lists

                cnt = 1

                @printf("Input: @array = %s\n", list)

                slice = Int64[]

                @printf("Output: ")

                while cnt < length(list)-1

                                push!(slice, list[cnt])

                                push!(slice, list[cnt + 1])

                                push!(slice, list[cnt + 2])

                                if length(slice) == 3

                                                retval = GetIntervals(slice)

                                                if retval == 1

                                                                @printf("%s ",slice)

                                                end

                                end

                                cnt += 1

                                slice = Int64[]

                end

                ret = GetIntervals(list)

                ret == 1 ? (println(list); println(" ")) : println("()")

end

 

#=

SAMPLE OUTPUT

julia .\ArithmeticSlices.jl

Input: @array = [1, 2, 3, 4]

Output: [1, 2, 3] [2, 3, 4] [1, 2, 3, 4]

 

Input: @array = [2]

Output: ()

=#
