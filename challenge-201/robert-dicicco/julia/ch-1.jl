#!/usr/bin/env julia

#=

AUTHOR: Robert DiCicco

DATE:   2023-01-23

Challenge 201 Missing Numbers ( Julia )

=#

using Printf



arrs = [[0,1,3],[0,1]]



for arr in arrs

    @printf("Input: @array = %s\n",arr)

    len = length(arr)

    for x = 0:len

        if !(x in arr)

            @printf("Output: %d\n\n", x)

        end

    end

end



#=

SAMPLE OUTPUT

julia .\MissingNumbers.jl

Input: @array = [0, 1, 3]

Output: 2



Input: @array = [0, 1]

Output: 2

=#
