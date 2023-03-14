' Challenge 199
'
' Task 1: Good Pairs
' Submitted by: Mohammad S Anwar
'
' You are given a list of integers, @list.
'
' Write a script to find the total count of Good Pairs.
'
'     A pair (i, j) is called good if list[i] == list[j] and i < j.
'
'
' Example 1
'
' Input: @list = (1,2,3,1,1,3)
' Output: 4
'
' There are 4 good pairs found as below:
' (0,3)
' (0,4)
' (3,4)
' (2,5)
'
' Example 2
'
' Input: @list = (1,2,3)
' Output: 0
'
' Example 3
'
' Input: @list = (1,1,1,1)
' Output: 6
'
' Good pairs are below:
' (0,1)
' (0,2)
' (0,3)
' (1,2)
' (1,3)
' (2,3)

sub collect_args(nums() as integer)
    dim i as integer
    i=0
    do while command(i+1)<>""
        redim preserve nums(i) as integer
        nums(i)=val(command(i+1))
        i=i+1
    loop
end sub

function count_good_pairs(nums() as integer) as integer
    dim count as integer, i as integer, j as integer
    count=0
    for i=0 to ubound(nums)-1
        for j=i+1 to ubound(nums)
            if nums(i)=nums(j) then count=count+1
        next
    next
    count_good_pairs=count
end function

dim nums() as integer
collect_args nums()
print count_good_pairs(nums())
