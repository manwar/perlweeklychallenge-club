' Challenge 201
'
' Task 1: Missing Numbers
' Submitted by: Mohammad S Anwar
'
' You are given an array of unique numbers.
'
' Write a script to find out all missing numbers in the range 0..$n where $n
' is the array size.
'
' Example 1
'
' Input: @array = (0,1,3)
' Output: 2
'
' The array size i.e. total element count is 3, so the range is 0..3.
' The missing number is 2 in the given array.
'
' Example 2
'
' Input: @array = (0,1)
' Output: 2
'
' The array size is 2, therefore the range is 0..2.
' The missing number is 2.

sub collect_args(nums() as integer)
    dim i as integer
    i=0
    do while command(i+1)<>""
        redim preserve nums(i) as integer
        nums(i)=val(command(i+1))
        i=i+1
    loop
end sub

dim nums() as integer, got() as boolean, i as integer

collect_args nums()
for i=0 to ubound(nums)
    if nums(i)>ubound(got) then redim preserve got(nums(i))
    got(nums(i))=true
next
for i=0 to ubound(nums)+1
    if i>ubound(got) then
        print i;
    elseif not got(i) then
        print i;
    end if
next
print
