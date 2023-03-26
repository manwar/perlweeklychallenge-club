' Challenge 197
'
' Task 2: Range List
' Submitted by: Mohammad S Anwar
' You are given a sorted unique integer array, @array.
'
' Write a script to find all possible Number Range i.e [x, y] represent range
' all integers from x and y (both inclusive).
'
'
' Each subsequence of two or more contiguous integers
'
'
' Example 1
' Input: @array = (1,3,4,5,7)
' Output: [3,5]
' Example 2
' Input: @array = (1,2,3,6,7,9)
' Output: [1,3], [6,7]
' Example 3
' Input: @array = (0,1,2,4,5,6,8,9)
' Output: [0,2], [4,6], [8,9]

sub collect_args(nums() as integer)
    dim i as integer
    i=0
    do while command(i+1)<>""
        redim preserve nums(i) as integer
        nums(i)=val(command(i+1))
        i=i+1
    loop
end sub

sub print_ranges(nums() as integer)
    dim i as integer, j as integer, sep as string
    print "(";
    i=0
    do while i<=ubound(nums)
        j=0
        do while i+j<=ubound(nums)
            if nums(i)+j<>nums(i+j) then
                exit do
            else
                j=j+1
            end if
        loop
        if j>1 then
            print sep;"[";nums(i);",";nums(i+j-1);"]";
            sep=", "
            i=i+j
        else
            i=i+1
        end if
    loop
    print ")"
end sub

dim nums() as integer
collect_args nums()
print_ranges nums()
