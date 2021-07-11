' Challenge 105
'
' TASK #1 › Nth root
' Submitted by: Mohammad S Anwar
' You are given positive numbers $N and $k.
'
' Write a script to find out the $Nth root of $k. For more information, please
' take a look at the wiki page.
'
' Example
' Input: $N = 5, $k = 248832
' Output: 12
'
' Input: $N = 5, $k = 34
' Output: 2.02

const ROUND_FACTOR as double = 10000.0

function round(n as double) as double
    round = int(n*ROUND_FACTOR+0.5)/ROUND_FACTOR
end function

dim n as integer, k as integer

n=val(command(1))
k=val(command(2))
print round(k^(1/n))
