' Challenge 099
'
' TASK #2 › Unique Sub-sequence
' Submitted by : Mohammad S Anwar
' You are given two strings $S and $T.
'
' Write a script to find out count of different unique sub-sequences matching
' $T without changing the position of characters.
'
' Example 1:
' Input : $S = "littleit', $T = 'lit'
' Output : 5
'
'     1: [lit] tleit
'     2: [li] t[t] leit
'     3: [li] ttlei[t]
'     4: litt[l] e[it]
'     5: [l] ittle[it]
' Example 2:
' Input : $S = "london', $T = 'lon'
' Output : 3
'
'     1: [lon] don
'     2: [lo] ndo[n]
'     3: [l] ond[on]

function count_subsequences(s as string, t as string) as integer
    dim matching as integer, notmatching as integer
    do
        if t="" then            ' t is empty, matched
            count_subsequences=1
            exit function
        elseif s="" then        ' s is empty, did not match
            count_subsequences=0
            exit function
        elseif left(s,1)=left(t,1) then ' same char, check two paths
            matching=count_subsequences(mid(s,2), mid(t,2))
            notmatching=count_subsequences(mid(s,2), t)
            count_subsequences=matching + notmatching
            exit function
        else                    ' different char, keep pattern
            s=mid(s,2)
        end if
    loop
end function

' main
print trim(str(count_subsequences(command(1), command(2))))
