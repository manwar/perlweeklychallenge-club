#!/usr/bin/env julia

#=

AUTHOR: Robert DiCicco

DATE  : 2023-01-30

Challenge 202 Consecutive Odds ( Julia )

=#



using Printf



arrays = [[1,5,3,6],[2,6,3,5],[1,2,3,4],[2,3,5,7]]



for arr in arrays

    check = ' '

    @printf("Input: @array = %s\n",arr)

    for x in 1:length(arr)

        arr[x] % 2 == 0  ? check *= 'e' : check *= 'o'

    end

    occursin(r"ooo", check) ? println("Output: 1\n") : println("Output: 0\n")

end



#=

SAMPLE OUTPUT

julia .\ConsecutiveOdds.jl

Input: @array = [1, 5, 3, 6]

Output: 1



Input: @array = [2, 6, 3, 5]

Output: 0



Input: @array = [1, 2, 3, 4]

Output: 0



Input: @array = [2, 3, 5, 7]

Output: 1

=#
