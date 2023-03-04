' Challenge 204
'
' Task 1: Monotonic Array
' Submitted by: Mohammad S Anwar
'
' You are given an array of integers.
'
' Write a script to find out if the given array is Monotonic. Print 1 if it is otherwise 0.
'
'     An array is Monotonic if it is either monotone increasing or decreasing.
'
' Monotone increasing: for i <= j , nums[i] <= nums[j]
' Monotone decreasing: for i <= j , nums[i] >= nums[j]
'
'
' Example 1
'
' Input: @nums = (1,2,2,3)
' Output: 1
'
' Example 2
'
' Input: @nums = (1,3,2)
' Output: 0
'
' Example 3
'
' Input: @nums = (6,5,5,4)
' Output: 1

' read command line arguments
sub read_args(nums() as integer)
    dim i as integer

    i=0
    do while command(i+1)<>""
        redim preserve nums(i) as integer
        nums(i) = val(command(i+1))
        i=i+1
    loop
end sub

' check if is monotonic
function is_monotonic(nums() as integer) as integer
    dim i as integer, delta as integer, climbing as integer, descending as integer

    for i=0 to ubound(nums)-1
        delta=nums(i+1)-nums(i)
        if delta>0 then climbing=1
        if delta<0 then descending=1
    next

    if climbing=1 and descending=1 then
        is_monotonic=0
    else
        is_monotonic=1
    end if
end function


dim nums() as integer
read_args nums()
print is_monotonic(nums())
