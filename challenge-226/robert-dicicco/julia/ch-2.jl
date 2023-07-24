#!/usr/bin/env julia
#=
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-20
Challenge 226 Task 2 Zero Array ( Julia)
--------------------------------------
=#
using Printf

ints = [[1, 5, 0, 3, 5],[0],[2, 1, 4, 0, 3]]
flag = 1

function GetMinint(x)
    cnt = 1
    minint = 100
    while cnt <= length(x)
        if x[cnt] > 0 && x[cnt] < minint
                minint = x[cnt]
        end
        cnt += 1
    end
    return minint
end

cycle = 1
for nts in ints
    global flag, cycle
    while flag == 1
        if (cycle == 1)
            @printf("Input: ints = %s\n",nts)
        end
        cnt = 1

        if length(nts) == 1 && nts[1] == 0
            #last
            break
        end

        #### find min of array ( not including zero )
        minint = GetMinint(nts)

        cnt = 1
        while cnt <= length(nts)
            if nts[cnt] > 0
                nts[cnt] -= minint
            end
            cnt += 1
        end

        @printf("operation cycle: pick %d %s\n",minint, nts)
        cycle +=1

        cnt = 1
        flag = 0
        while  cnt <= length(nts)
            if (nts[cnt] > 0)
                flag = 1
            end
            cnt += 1
        end
     end
     cycle -= 1
     @printf("Output: %d\n\n",cycle)
     flag = 1
     cycle = 1
end
#=
--------------------------------------
SAMPLE OUTPUT
julia .\ZeroArray.jl

Input: ints = [1, 5, 0, 3, 5]
operation cycle: pick 1 [0, 4, 0, 2, 4]
operation cycle: pick 2 [0, 2, 0, 0, 2]
operation cycle: pick 2 [0, 0, 0, 0, 0]
Output: 3

Input: ints = [0]
Output: 0

Input: ints = [2, 1, 4, 0, 3]
operation cycle: pick 1 [1, 0, 3, 0, 2]
operation cycle: pick 1 [0, 0, 2, 0, 1]
operation cycle: pick 1 [0, 0, 1, 0, 0]
operation cycle: pick 1 [0, 0, 0, 0, 0]
Output: 4
--------------------------------------
=#


