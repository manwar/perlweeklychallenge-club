' Challenge 202
'
' Task 2: Widest Valley
' Submitted by: E. Choroba
'
' Given a profile as a list of altitudes, return the leftmost widest valley.
' A valley is defined as a subarray of the profile consisting of two parts:
' the first part is non-increasing and the second part is non-decreasing.
' Either part can be empty.
'
' Example 1
'
' Input: 1, 5, 5, 2, 8
' Output: 5, 5, 2, 8
'
' Example 2
'
' Input: 2, 6, 8, 5
' Output: 2, 6, 8
'
' Example 3
'
' Input: 9, 8, 13, 13, 2, 2, 15, 17
' Output: 13, 13, 2, 2, 15, 17
'
' Example 4
'
' Input: 2, 1, 2, 1, 3
' Output: 2, 1, 2
'
' Example 5
'
' Input: 1, 3, 3, 2, 1, 2, 3, 3, 2
' Output: 3, 3, 2, 1, 2, 3, 3

sub collect_args(nums() as integer)
    dim i as integer
    i=0
    do while command(i+1)<>""
        redim preserve nums(i) as integer
        nums(i)=val(command(i+1))
        i=i+1
    loop
end sub

sub largest_valey(heights() as integer, valey() as integer)
    dim c as integer, l as integer, r as integer, i as integer
    dim l1 as integer, r1 as integer

    l1=0: r1=-1                 ' initial interval
    for c=0 to ubound(heights)  ' center of valey

        l=c                     ' left
        do while l>0
            if heights(l-1)>=heights(l) then
                l=l-1
            else
                exit do
            end if
        loop

        r=c                     ' right
        do while r<ubound(heights)
            if heights(r+1)>=heights(r) then
                r=r+1
            else
                exit do
            end if
        loop

        if r-l+1>r1-l1+1 then
            l1=l: r1=r
        end if
    next

    redim valey(r1-l1)
    for i=0 to r1-l1
        valey(i)=heights(i+l1)
    next
end sub

dim heights() as integer, valey() as integer, i as integer
collect_args heights()
largest_valey heights(), valey()
for i=0 to ubound(valey)
    print valey(i);
next
print
