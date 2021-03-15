' Challenge 099
' 
' TASK #1 › Pattern Match
' Submitted by: Mohammad S Anwar
' You are given a string $S and a pattern $P.
'
' Write a script to check if given pattern validate the entire string.
' Print 1 if pass otherwise 0.
'
' The patterns can also have the following characters:
'
' ? - Match any single character.
' * - Match any sequence of characters.
' Example 1:
' Input: $S = "abcde" $P = "a*e"
' Output: 1
' Example 2:
' Input: $S = "abcde" $P = "a*d"
' Output: 0
' Example 3:
' Input: $S = "abcde" $P = "?b*d"
' Output: 0
' Example 4:
' Input: $S = "abcde" $P = "a*c?e"
' Output: 1

function match(s as string, p as string) as boolean
    dim i as integer
    do
        if s="" and p="" then       ' string and pattern finished
            match=true
            exit function
        elseif s="" or p="" then    ' string or pattern finished
            match=false
            exit function
        elseif left(p,1)="?" then   ' match any character
            s=mid(s,2)
            p=mid(p,2)
        elseif left(p,1)="*" then   ' match any sub-sequence
            p=mid(p,2)
            for i=1 to len(s)
                if match(mid(s,i), p) then
                    match=true
                    exit function
                end if
            next i
            match=false
            exit function
        elseif left(s,1)<>left(p,1) then ' chars different
            match=false
            exit function
        else
            s=mid(s,2)
            p=mid(p,2)
        end if
    loop
end function

' main
if match(command(1), command(2)) then
    print "1"
else
    print "0"
end if
