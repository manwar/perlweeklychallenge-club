' Challenge 098
'
' TASK #2 › Search Insert Position
' Submitted by: Mohammad S Anwar
' You are given a sorted array of distinct integers @N and a target $N.
'
' Write a script to return the index of the given target if found
' otherwise place the target in the sorted array and return the index.
'
' Example 1:
' Input: @N = (1, 2, 3, 4) and $N = 3
' Output: 2 since the target 3 is in the array at the index 2.
' Example 2:
' Input: @N = (1, 3, 5, 7) and $N = 6
' Output: 3 since the target 6 is missing and should be placed at
' the index 3.
' Example 3:
' Input: @N = (12, 14, 16, 18) and $N = 10
' Output: 0 since the target 10 is missing and should be placed at
' the index 0.
' Example 4:
' Input: @N = (11, 13, 15, 17) and $N = 19
' Output: 4 since the target 19 is missing and should be placed at
' the index 4.

' insert element in array at the given position
sub insert(aN() as integer, nPos as integer, n as integer)
    dim u as integer, i as integer
    u=ubound(aN)
    redim preserve aN(u+1)
    if nPos>u then      ' append
        aN(u+1)=n
    else                ' shift all and insert
        for i = u+1 to nPos step -1
            aN(i)=aN(i-1)
        next i
        aN(nPos)=n
    end if
end sub

' print list of numbers
sub print_numbers(aN() as integer)
    dim sep as string, i as integer
    sep="("
    for i=lbound(aN) to ubound(aN)
        print sep;trim(str(aN(i)));
        sep=", "
    next i
    print ")"
end sub

' search for index of element, insert in array if not found
function search_insert(aN() as integer, n as integer) as integer
    dim b as integer, t as integer, m as integer
    b=lbound(aN): t=ubound(aN)
    if t<b then                 ' empty
        insert aN(), 0, n: search_insert=0
    elseif n<aN(b) then         ' before first
        insert aN(), b, n: search_insert=b
    elseif n>aN(t) then         ' after last
        insert aN(), t+1, n: search_insert=t+1
    else
        m=(t+b)/2
        do while b+1<t          ' bisect loop
            if n=aN(m) then
                search_insert=m: exit function
            elseif n<aN(m) then
                t=m
            else
                b=m
            end if
            m=(t+b)/2
        loop
        insert aN(), m+1, n: search_insert=m+1  ' not found, insert
    end if
end function

' main
dim aN() as integer, i as integer, n as integer
n=val(command(1))
i=2
do while command(i)<>""
    redim preserve aN(i-2)
    aN(i-2)=val(command(i))
    i=i+1
loop

print trim(str(search_insert(aN(), n)))
print_numbers aN()
