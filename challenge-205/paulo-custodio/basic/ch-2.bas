' Challenge 205
'
' Task 2: Maximum XOR
' Submitted by: Mohammad S Anwar
'
' You are given an array of integers.
'
' Write a script to find the highest value obtained by XORing any two distinct members of the array.
' Example 1
'
' Input: @array = (1,2,3,4,5,6,7)
' Output: 7
'
' The maximum result of 1 xor 6 = 7.
'
' Example 2
'
' Input: @array = (2,4,1,3)
' Output: 7
'
' The maximum result of 4 xor 3 = 7.
'
' Example 3
'
' Input: @array = (10,5,7,12,8)
' Output: 15
'
' The maximum result of 10 xor 5 = 15.

dim nums() as integer

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

' compute highest xor of any pair
function max_xor(nums() as integer) as integer
    dim max as integer, n as integer, i as integer, j as integer

    max=0
    for i=lbound(nums) to ubound(nums)-1
        for j=i+1 to ubound(nums)
            n=nums(i) xor nums(j)
            if n>max then
                max=n
            end if
        next
    next
    max_xor=max
end function


read_args nums()
print max_xor(nums())
