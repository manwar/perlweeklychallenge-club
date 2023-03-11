' Challenge 201
'
' Task 2: Penny Piles
' Submitted by: Robbie Hatley
'
' You are given an integer, $n > 0.
'
' Write a script to determine the number of ways of putting $n pennies in a row
' of piles of ascending heights from left to right.
' Example
'
' Input: $n = 5
' Output: 7
'
' Since $n=5, there are 7 ways of stacking 5 pennies in ascending piles:
'
'     1 1 1 1 1
'     1 1 1 2
'     1 2 2
'     1 1 3
'     2 3
'     1 4
'     5

function make_piles1(prev as integer, n as integer) as integer
    dim count as integer, i as integer, max as integer

    count=0
    if n=0 then
        count=count+1
    elseif n>0 then
        if prev<0 then
            max=n
        else
            max=prev
        endif
        for i=1 to max
            count=count+make_piles1(i, n-i)
        next
    end if
    make_piles1=count
end function

function make_piles(n as integer) as integer
    make_piles=make_piles1(-1,n)
end function

print make_piles(val(command(1)))
