' Challenge 205
'
' Task 1: Third Highest
' Submitted by: Mohammad S Anwar
'
' You are given an array of integers.
'
' Write a script to find out the Third Highest if found otherwise return the maximum.
' Example 1
'
' Input: @array = (5,3,4)
' Output: 3
'
' First highest is 5. Second highest is 4. Third highest is 3.
'
' Example 2
'
' Input: @array = (5,6)
' Output: 6
'
' First highest is 6. Second highest is 5. Third highest is missing, so maximum is returned.
'
' Example 3
'
' Input: @array = (5,4,4,3)
' Output: 3
'
' First highest is 5. Second highest is 4. Third highest is 3.

dim nums() as integer

' read command line arguments
sub read_args(nums() as integer)
    dim i as integer

    i=0
    do while command(i+1)<>""
        redim preserve nums(i) as integer
        nums(i) = val(command(i+1))
        i=i+1
    loop
end sub

' reverse sort array
sub rsort(nums() as integer)
    dim i as integer, j as integer, n as integer

    for i=lbound(nums) to ubound(nums)-1
        for j=i+1 to ubound(nums)
            if nums(i)<nums(j) then
                n=nums(i): nums(i)=nums(j): nums(j)=n
            end if
        next
    next
end sub


' remove duplicates from array
sub uniq(nums() as integer)
    dim i as integer, j as integer, last as integer

    if ubound(nums)>=lbound(nums) then
        i=lbound(nums)
        j=lbound(nums)
        last=nums(i)+1
        do while i<=ubound(nums)
            if nums(i)<>last then
                nums(j)=nums(i)
                last=nums(i)
                j=j+1
            end if
            i=i+1
        loop
    end if
end sub

read_args nums()
rsort nums()
uniq nums()

if ubound(nums)<lbound(nums) then
    print 0
elseif ubound(nums)-lbound(nums)+1<3 then
    print nums(lbound(nums))
else
    print nums(lbound(nums)+2)
end if
