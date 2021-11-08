' Challenge 119
'
' TASK #2 - Sequence without 1-on-1
' Submitted by: Cheok-Yin Fung
' Write a script to generate sequence starting at 1. Consider the increasing
' sequence of integers which contain only 1's, 2's and 3's, and do not have any
' doublets of 1's like below. Please accept a positive integer $N and print the
' $Nth term in the generated sequence.
'
' 1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131, ...
'
' Example
' Input: $N = 5
' Output: 13
'
' Input: $N = 10
' Output: 32
'
' Input: $N = 60
' Output: 2223

dim shared n as integer

function num_ok(n as integer) as boolean
    dim last_digit as integer, digit as integer
    num_ok = false
    if n <= 0 then exit function
    do while n > 0
        last_digit = digit
        digit = n mod 10
        n = n \ 10
        if digit < 1 or digit > 3 or _
           (digit = 1 and last_digit = 1) then
            exit function
        end if
    loop
    num_ok = true
end function

sub next_seq()
    do
        n = n+1
        if num_ok(n) then exit sub
    loop
end sub

dim num as integer, i as integer
num = val(command(1))
for i=1 to num: next_seq: next i
print n
