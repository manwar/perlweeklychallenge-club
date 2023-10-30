#!/usr/bin/env julia
#=
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-25
Challenge 236 Task 01 Exact Change ( Julia )
-------------------------------------
=#

using Printf

bills = [[5, 5, 5, 10, 20], [5, 5, 10, 10, 20],[5, 5, 5, 20]]

for paid in bills
    @printf("Input: @bills = %s\n", paid)
    cnt = 1
    change = 0
    while cnt <=length(paid)
        ticket = paid[cnt]
        change_required = ticket - 5
        if ticket == 5
            change += 5
        elseif ticket == 10
            change += 0
        elseif ticket == 20
            if change_required > change
                @printf("Output: false\n\n")
                break
            else
                @printf("Output: true\n\n")
                break
            end
            change -= 10
        end
        cnt += 1
    end
end

#=
--------------------------------------
SAMPLE OUTPUT
julia .\ExactChange.jl

Input: @bills = [5, 5, 5, 10, 20]
Output: true

Input: @bills = [5, 5, 10, 10, 20]
Output: false

Input: @bills = [5, 5, 5, 20]
Output: true
-------------------------------------
=#


