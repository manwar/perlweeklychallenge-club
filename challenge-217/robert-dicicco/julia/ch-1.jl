#!/usr/bin/env julia
#=
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-15
Challenge 217 Sorted Matrix ( Julia )
--------------------------------------
=#
using Printf

function checkArgs(args)
  global arg
  try
    arg = parse(Int64, args[1])
  catch
    println("Error: Argument must be an integer")
    exit(0)
  finally
    main(arg)
  end
end


matrix = []
out = []

function main(arg)
    global matrix, out
    if arg == 0
        matrix = [[3,1,2],[5,2,4],[0,1,3]]
    elseif arg == 1
        matrix =  [[2,1], [4,5]]
        #println(matrix)
    elseif arg == 2
        matrix = [[1,0,3],[0,0,0],[ 1,2,1]];
        #println(matrix)
    else
        println("Error! arg must be between 0 and 2 inclusive")
    end
    @printf("Input: @matrix = %s\n",matrix)
    for arr in matrix
        for val in arr
            push!(out, val)
        end
    end
    @printf("%s\n",sort(out)[3])
end

checkArgs(ARGS)

#=
--------------------------------------
SAMPLE OUTPUT
julia .\SortedMatrix.jl 0
Input: @matrix = [[3, 1, 2], [5, 2, 4], [0, 1, 3]]
1

PS G:\Projects\Perl\Challenges> julia .\SortedMatrix.jl 1
Input: @matrix = [[2, 1], [4, 5]]
4

PS G:\Projects\Perl\Challenges> julia .\SortedMatrix.jl 2
Input: @matrix = [[1, 0, 3], [0, 0, 0], [1, 2, 1]]
0
--------------------------------------
=#


