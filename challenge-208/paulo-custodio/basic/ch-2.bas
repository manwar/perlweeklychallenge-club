' Challenge 208
'
' Task 2: Duplicate and Missing
' Submitted by: Mohammad S Anwar
'
' You are given an array of integers in sequence with one missing and one duplicate.
'
' Write a script to find the duplicate and missing integer in the given array.
' Return -1 if none found.
'
' For the sake of this task, let us assume the array contains no more than one
' duplicate and missing.
'
' Example 1:
'
' Input: @nums = (1,2,2,4)
' Output: (2,3)
'
' Duplicate is 2 and Missing is 3.
'
' Example 2:
'
' Input: @nums = (1,2,3,4)
' Output: -1
'
' No duplicate and missing found.
'
' Example 3:
'
' Input: @nums = (1,2,3,3)
' Output: (3,4)
'
' Duplicate is 3 and Missing is 4.

sub collect_args(nums() as integer)
    dim i as integer
    i=0
    do while command(i+1)<>""
        redim preserve nums(i) as integer
        nums(i)=val(command(i+1))
        i=i+1
    loop
end sub

function count_nums(nums() as integer, n as integer) as integer
    dim i as integer, count as integer
    count=0
    for i=0 to ubound(nums)
        if nums(i)=n then count=count+1
    next
    count_nums=count
end function

sub print_dups_missing(nums() as integer)
    dim i as integer, count as integer, found as boolean
    found=false
    ' find dups
    for i=1 to ubound(nums)+1
        if count_nums(nums(), i)>1 then print i; :found=true
    next
    ' find missing
    for i=1 to ubound(nums)+1
        if count_nums(nums(), i)=0 then print i; :found=true
    next
    if found then print: else print -1
end sub

dim nums() as integer
collect_args nums()
print_dups_missing nums()
