#!/usr/bin/env julia
#=
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-03
Challenge 215 Number Placement ( Julia )
-----------------------------------------
=#
using Printf

numbers = [[1,0,0,0,1],[1,0,0,0,1],[1,0,0,0,0,0,0,0,1]];
counts  = [1,2,3]

cnt=1

function CheckZeroes(arr)
    zcnt = 1;
    while zcnt < length(arr)
        if ((arr[zcnt] == 0) && (arr[zcnt-1] == 0))
             arr[zcnt] = 1;
        end
        zcnt += 1;
    end
    @printf("Output: 1 = %s\n\n",arr)
end

function HowManyZeroes(arr)
    z = 1
    zcnt = 0
    while z < (length(arr))
        if (arr[z] == 0)
            zcnt += 1
        end
        z += 1
    end
    return zcnt
end

for nums in numbers
    global cnt
    @printf("Input: @numbers = %s  Count = %d\n",nums,counts[cnt])
    zeroes = HowManyZeroes(nums)
    if (zeroes < cnt * 2)
        @printf("Output: 0\n\n")
    else
        CheckZeroes(nums)
    end
    cnt += 1
end

#=
-----------------------------------------
SAMPLE OUTPUT
julia .\NumberPlacement.jl
Input: @numbers = [1, 0, 0, 0, 1]  Count = 1
Output: 1 = [1, 0, 1, 0, 1]

Input: @numbers = [1, 0, 0, 0, 1]  Count = 2
Output: 0

Input: @numbers = [1, 0, 0, 0, 0, 0, 0, 0, 1]  Count = 3
Output: 1 = [1, 0, 1, 0, 1, 0, 1, 0, 1]
-----------------------------------------
=#


