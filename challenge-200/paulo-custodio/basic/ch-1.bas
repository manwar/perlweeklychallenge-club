' Challenge 200
'
' Task 1: Arithmetic Slices
' Submitted by: Mohammad S Anwar
' You are given an array of integers.
'
' Write a script to find out all Arithmetic Slices for the given array of integers.
'
' An integer array is called arithmetic if it has at least 3 elements and the
' differences between any three consecutive elements are the same.
'
'
' Example 1
' Input: @array = (1,2,3,4)
' Output: (1,2,3), (2,3,4), (1,2,3,4)
' Example 2
' Input: @array = (2)
' Output: () as no slice found.

function is_arithmetic(nums() as integer, i1 as integer, i2 as integer) as boolean
    dim st as integer, i as integer

    is_arithmetic=true
    if i2-i1+1<3 then
        is_arithmetic=false
    else
        st=nums(i1+1)-nums(i1)
        for i=i1+2 to i2
            if nums(i)-nums(i-1)<>st then
                is_arithmetic=false
                exit for
            end if
        next
    end if
end function

sub slices(nums() as integer)
    dim sep as string, i as integer, j as integer, k as integer

    sep=""
    print "(";
    for i=0 to ubound(nums)-2
        for j=i+2 to ubound(nums)
            if is_arithmetic(nums(), i, j) then
                print sep;
                sep="), ("
                for k=i to j
                    print trim(str(nums(k)));
                    if k<>j then print ",";
                next
            end if
        next
    next
    print ")"
end sub

sub collect_args(nums() as integer)
    dim i as integer

    i=0
    do while command(i+1)<>""
        redim preserve nums(i)
        nums(i)=val(command(i+1))
        i=i+1
    loop
end sub


dim nums() as integer
collect_args nums()
slices nums()

