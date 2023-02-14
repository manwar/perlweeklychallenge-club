#!/usr/bin/env julia

#=

-----------------------------------------

AUTHOR: Robert DiCicco

DATE  : 2023-02-13

Challenge 204 Monotonic Array ( Julia )

-----------------------------------------

=#

using Printf



nums = [[1,2,2,3],[1,3,2],[6,5,5,4]]



function CheckIncreasing(arr, ln)

    cnt = 1

    while cnt < ln

        arr[cnt + 1] >= arr[cnt] ? (cnt += 1) : (return 0)

    end

    return 1

end



function CheckDecreasing(arr, ln)

    cnt = 1

    while cnt < ln

        arr[cnt + 1] <= arr[cnt] ? (cnt += 1) : (return 0)

    end

    return 1

end



for n in nums

    @printf("Input: @nums = %s\n", n)

    len = length(n)

    if (CheckIncreasing(n, len) == 0) && (CheckDecreasing(n,len) == 0)

        println("0")

    end

    if (CheckIncreasing(n, len) == 1) || (CheckDecreasing(n,len) == 1)

        println("1")

    end

end



#=

-----------------------------------------

SAMPLE OUTPUY

julia .\Monotones.jl

Input: @nums = [1, 2, 2, 3]

1

Input: @nums = [1, 3, 2]

0

Input: @nums = [6, 5, 5, 4]

1

-----------------------------------------

=#
