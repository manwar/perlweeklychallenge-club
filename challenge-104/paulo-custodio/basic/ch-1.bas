' Challenge 104
'
' TASK #1 › FUSC Sequence
' Submitted by: Mohammad S Anwar
' Write a script to generate first 50 members of FUSC Sequence. Please refer to
' OEIS for more information.
'
' The sequence defined as below:
'
' fusc(0) = 0
' fusc(1) = 1
' for n > 1:
' when n is even: fusc(n) = fusc(n / 2),
' when n is odd: fusc(n) = fusc((n-1)/2) + fusc((n+1)/2)

function fusc(n as integer) as integer
    if n=0 then
        fusc=0
    elseif n=1 then
        fusc=1
    elseif (n and 1)=0 then
        fusc=fusc(n/2)
    else
        fusc=fusc((n-1)/2)+fusc((n+1)/2)
    end if
end function

dim i as integer, n as integer
n=val(command(1))
for i=0 to n-1
    print trim(str(fusc(i)));" ";
next
print
