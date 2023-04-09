#!/usr/bin/env julia
#=
-------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-08
Challenge 211 Toeplitz Matrix ( Julia )
-------------------------------------------
=#

using Printf

matrx = [ [4, 3, 2, 1],[5, 4, 3, 2],[6, 5, 4, 3], ]

#matrx = [ [1,2,3],[3,2,1] ]


rows = length(matrx)
cols = length(matrx[1])

r = 1
c = 1

outarr = []
flag = 0

function CheckDiag(o)
    global flag
    arr_u = unique(o)
    if length(arr_u) != 1
        flag = -1
    end
end

function Diag(c,r)
    global rows, cols,outarr
    outarr = []
    while r <= rows
        push!(outarr,matrx[r][c])
        if r == rows
            CheckDiag(outarr)
            return
        else
            if c == cols
                CheckDiag(outarr)
                break
            end
            c += 1
            r += 1
        end
    end
end


function main()
    global c, r
    @printf("Input: @matrix = %s\n", matrx)
    c = 1
    r = 1
    while c <= cols
        Diag(c,r)
        c = c + 1
    end

    r = 2
    c = 1
    while r <= rows
        Diag(c,r)
        r = r + 1
    end
    flag == -1 ? println("Output: false") : println("Output: true")
end

main()

#=
-------------------------------------------
SAMPLE OUTPUT
julia .\Toeplitz.jl
Input: @matrix = [[4, 3, 2, 1], [5, 4, 3, 2], [6, 5, 4, 3]]
Output: true

julia .\Toeplitz.jl
Input: @matrix = [[1, 2, 3], [3, 2, 1]]
Output: false
-------------------------------------------
=#


