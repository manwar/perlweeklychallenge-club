' Challenge 195
'
' Task 1: Special Integers
' Submitted by: Mohammad S Anwar
' You are given a positive integer, $n > 0.
'
' Write a script to print the count of all special integers between 1 and $n.
'
' An integer is special when all of its digits are unique.
'
' Example 1:
' Input: $n = 15
' Output: 14 as except 11 all other integers between 1 and 15 are spcial.
' Example 2:
' Input: $n = 35
' Output: 32 as except 11, 22, 33 all others are special.

function is_special_int(n as integer) as boolean
    dim digits(9) as integer, digit as integer
    do while n>0
        digit=n mod 10
        n=n/10
        if digits(digit)>0 then
            is_special_int=false
            exit function
        else
            digits(digit)=1
        end if
    loop
    is_special_int=true
end function

function count_special_ints(n as integer) as integer
    dim i as integer, count as integer
    count=0
    for i=1 to n
        if is_special_int(i) then count=count+1
    next
    count_special_ints=count
end function

print count_special_ints(val(command(1)))
