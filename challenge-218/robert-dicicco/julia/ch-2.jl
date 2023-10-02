#!/usr/bin/env julia
#---------------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-05-27
# Challenge 218 MatrixScore.py ( Julia )
#---------------------------------------------
using Printf

matrix = [ [0,0,1,1],
           [1,0,1,0],
           [1,1,0,0], ]

function ToggleRow(r, ov)
    testmat = []
    col = 1
    while col < 5
        x = matrix[r][col]
        if x == 0
            push!(testmat,1)
        else
            push!(testmat,0)
        end
        col += 1
    end
    testval = binary_to_decimal(testmat)
    if testval > ov
        @printf("\nToggled row %d\n",r)
        matrix[r] = testmat
        ShowMatrix()
    end
end

function ToggleCol(c)
    ov = GetColVal(c);
    row = 1;
    testmat = [];
    testval = 0;
    while row <= 3
        matrix[row][c] == 0 ? push!(testmat,1) : push!(testmat,0)
        row += 1
    end
    testval = binary_to_decimal(testmat);
    if testval > ov
        for x in (1:3)
            matrix[x][c] = testmat[x]
        end
        @printf("Toggled column %d\n",c);
        ShowMatrix();
    end
end


function binary_to_decimal(binary_array)
    decimal = 0
    power = length(binary_array) - 1
    for digit in binary_array
        decimal += digit * ( 2 ^ power)
        power -= 1
    end
    return decimal
end

function ShowMatrix()
    total = 0
    cnt = 1
    while cnt <= 3
        @printf("%s\n",matrix[cnt])
        total += binary_to_decimal(matrix[cnt])
        cnt += 1
    end
    @printf("Total = %d\n\n",total)
end

function GetColVal(c)
    testmat = []
    row = 1
    while row <= 3
        push!(testmat,matrix[row][c])
        row += 1
    end
    colval = binary_to_decimal(testmat)
    return colval
end

ShowMatrix()
for myrow in (1:3)
    bd = binary_to_decimal(matrix[myrow])
    ToggleRow(myrow,bd)
end


for mycol in (1:4)
    ToggleCol(mycol)
end

#=
#---------------------------------------------
SAMPLE OUTPUT
julia .\MatrixScore.jl

[0, 0, 1, 1]
[1, 0, 1, 0]
[1, 1, 0, 0]
Total = 25

Toggled row 1
[1, 1, 0, 0]
[1, 0, 1, 0]
[1, 1, 0, 0]
Total = 34

Toggled column 3
[1, 1, 1, 0]
[1, 0, 0, 0]
[1, 1, 1, 0]
Total = 36

Toggled column 4
[1, 1, 1, 1]
[1, 0, 0, 1]
[1, 1, 1, 1]
Total = 39

#---------------------------------------------
=#


