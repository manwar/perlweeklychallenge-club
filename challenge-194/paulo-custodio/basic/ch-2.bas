' Challenge 194
'
' Task 2: Frequency Equalizer
' Submitted by: Mohammad S Anwar
' You are given a string made of alphabetic characters only, a-z.
'
' Write a script to determine whether removing only one character can make the
' frequency of the remaining characters the same.
'
' Example 1:
' Input: $s = 'abbc'
' Output: 1 since removing one alphabet 'b' will give us 'abc' where each
' alphabet frequency is the same.
' Example 2:
' Input: $s = 'xyzyyxz'
' Output: 1 since removing 'y' will give us 'xzyyxz'.
' Example 3:
' Input: $s = 'xzxz'
' Output: 0 since removing any one alphabet would not give us string with same
' frequency alphabet.

function freq_equalizer(s as string) as integer
    dim freq(25) as integer
    dim i as integer, l as integer, min as integer, max as integer, count as integer
    if s="" then freq_equalizer=0: exit function
    for i=1 to len(s)
        if mid(s,i,1)>="a" and mid(s,i,1)<="z" then
            l=asc(mid(s,i,1))-asc("a")
            freq(l)=freq(l)+1
        end if
    next
    min=0
    for i=0 to ubound(freq)
        if freq(i)<>0 then
            if min=0 then
                min=freq(i)
                max=freq(i)
            end if
            if min>freq(i) then min=freq(i)
            if max<freq(i) then max=freq(i)
        end if
    next
    if min+1<>max then freq_equalizer=0: exit function
    count=0
    for i=0 to ubound(freq)
        if freq(i)=max then count=count+1
    next
    if count=1 then
        freq_equalizer=1
    else
        freq_equalizer=0
    end if
end function

print freq_equalizer(command(1))
