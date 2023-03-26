' Challenge 194
'
' Task 1: Digital Clock
' Submitted by: Mohammad S Anwar
' You are given time in the format hh:mm with one missing digit.
'
' Write a script to find the highest digit between 0-9 that makes it valid time.
'
' Example 1
' Input: $time = '?5:00'
' Output: 1
'
' Since 05:00 and 15:00 are valid time and no other digits can fit in the missing place.
' Example 2
' Input: $time = '?3:00'
' Output: 2
' Example 3
' Input: $time = '1?:00'
' Output: 9
' Example 4
' Input: $time = '2?:00'
' Output: 3
' Example 5
' Input: $time = '12:?5'
' Output: 5
' Example 6
' Input: $time =  '12:5?'
' Output: 9

sub check_digit(s as string)
    if len(s)=1 and (s="?" or (s>="0" and s<="9")) then
        exit sub
    else
        print "invalid digit:";s
        end
    end if
end sub

function missing_digit(clock as string) as integer
    dim h1 as string, h2 as string, m1 as string, m2 as string, col as string
    h1=mid(clock,1,1): check_digit h1
    h2=mid(clock,2,1): check_digit h2
    col=mid(clock,3,1): if col<>":" then print "invalid clock:";clock: end
    m1=mid(clock,4,1): check_digit m1
    m2=mid(clock,5,1): check_digit m2
    if h1="?" and h2<="3" then missing_digit=2: exit function
    if h1="?" then missing_digit=1: exit function
    if h1<="1" and h2="?" then missing_digit=9: exit function
    if h2="?" then missing_digit=3: exit function
    if m1="?" then missing_digit=5: exit function
    if m2="?" then missing_digit=9: exit function
    print "invalid clock:";clock: end
end function

print missing_digit(command(1))
