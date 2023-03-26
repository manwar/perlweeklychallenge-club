' Challenge 209
'
' Task 1: Special Bit Characters
' Submitted by: Mohammad S Anwar
'
' You are given an array of binary bits that ends with 0.
'
' Valid sequences in the bit string are:
'
' [0] -decodes-to-> "a"
' [1, 0] -> "b"
' [1, 1] -> "c"
'
' Write a script to print 1 if the last character is an “a” otherwise print 0.
' Example 1
'
' Input: @bits = (1, 0, 0)
' Output: 1
'
' The given array bits can be decoded as 2-bits character (10) followed by
' 1-bit character (0).
'
' Example 2
'
' Input: @bits = (1, 1, 1, 0)
' Output: 0
'
' Possible decode can be 2-bits character (11) followed by 2-bits character
' (10) i.e. the last character is not 1-bit character.

function decode(in as string) as string
    dim result as string
    do while in<>""
        if left(in,1)="0" then
            result=result+"a"
            in=mid(in,2)
        elseif left(in,2)="10" then
            result=result+"b"
            in=mid(in,3)
        elseif left(in,2)="11" then
            result=result+"c"
            in=mid(in,3)
        else
            print "Error: cannot parse: "; in
            end
        end if
    loop
    decode=result
end function

dim in as string, result as string
in=command(1)
result=decode(in)
if right(result,1)="a" then print 1: else print 0
