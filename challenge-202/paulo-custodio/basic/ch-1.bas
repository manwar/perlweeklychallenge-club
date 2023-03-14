' Challenge 202
'
' Task 1: Consecutive Odds
' Submitted by: Mohammad S Anwar
'
' You are given an array of integers.
'
' Write a script to print 1 if there are THREE consecutive odds in the given array
' otherwise print 0.
'
' Example 1
'
' Input: @array = (1,5,3,6)
' Output: 1
'
' Example 2
'
' Input: @array = (2,6,3,5)
' Output: 0
'
' Example 3
'
' Input: @array = (1,2,3,4)
' Output: 0
'
' Example 4
'
' Input: @array = (2,3,5,7)
' Output: 1

sub collect_args(nums() as integer)
    dim i as integer
    i=0
    do while command(i+1)<>""
        redim preserve nums(i) as integer
        nums(i)=val(command(i+1))
        i=i+1
    loop
end sub

function is_odd(n as integer) as boolean
    if n mod 2=0 then
        is_odd=false
    else
        is_odd=true
    end if
end function

function three_consecutive_odds(nums() as integer) as integer
    dim i as integer
    for i=0 to ubound(nums)-2
        if is_odd(nums(i)) and is_odd(nums(i+1)) and is_odd(nums(i+2)) then
            three_consecutive_odds=1
            exit function
        end if
    next
    three_consecutive_odds=0
end function

dim nums() as integer
collect_args nums()
print three_consecutive_odds(nums())
