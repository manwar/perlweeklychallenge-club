' Challenge 100
'
' TASK #2 > Triangle Sum
' Submitted by: Mohammad S Anwar
' You are given triangle array.
'
' Write a script to find the minimum path sum from top to bottom.
'
' When you are on index i on the current row then you may move to either
' index i or index i + 1 on the next row.
'
' Example 1:
' Input: Triangle = [ [1], [2,4], [6,4,9], [5,1,7,2] ]
' Output: 8
'
' Explanation: The given triangle
'
'             1
'            2 4
'           6 4 9
'          5 1 7 2
'
' The minimum path sum from top to bottom:  1 + 2 + 4 + 1 = 8
'
'              [1]
'            [2]  4
'            6 [4] 9
'           5 [1] 7 2
' Example 2:
' Input: Triangle = [ [3], [3,1], [5,2,3], [4,3,1,3] ]
' Output: 7
'
' Explanation: The given triangle
'
'             3
'            3 1
'           5 2 3
'          4 3 1 3
'
' The minimum path sum from top to bottom: 3 + 1 + 2 + 1 = 7
'
'              [3]
'             3  [1]
'            5 [2] 3
'           4 3 [1] 3

const as integer MAX_ROWS = 20
 dim shared triangle(MAX_ROWS, MAX_ROWS) as integer
dim shared rows as integer

sub add_row(row as integer, text as string)
    dim as integer i, n
    rows = row
    for i = 1 to row
        do while left(text,1)<"0" or left(text,1)>"9"
            text = mid(text,2)
        loop
        n = val(text)
        do while left(text,1)>="0" and left(text,1)<="9"
            text = mid(text,2)
        loop
        triangle(row, i) = n
    next i
end sub

function min_sum_1(sum as integer, row as integer, col as integer) as integer
    dim as integer sum1, sum2
    sum = sum + triangle(row, col)
    if row = rows then
        min_sum_1 = sum
    else
        sum1 = min_sum_1(sum, row+1, col)
        sum2 = min_sum_1(sum, row+1, col+1)
        if sum1 < sum2 then
            min_sum_1 = sum1
        else
            min_sum_1 = sum2
        end if
    end if
end function

function min_sum() as integer
    min_sum = min_sum_1(0, 1, 1)
end function


dim i as integer
i = 1
do while command(i) <> ""
    add_row(i, command(i))
    i = i + 1
loop
print trim(str(min_sum()))
