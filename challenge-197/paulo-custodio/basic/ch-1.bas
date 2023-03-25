' Challenge 197
'
' Task 1: Move Zero
' Submitted by: Mohammad S Anwar
' You are given a list of integers, @list.
'
' Write a script to move all zero, if exists, to the end while maintaining
' the relative order of non-zero elements.
'
'
' Example 1
' Input:  @list = (1, 0, 3, 0, 0, 5)
' Output: (1, 3, 5, 0, 0, 0)
' Example 2
' Input: @list = (1, 6, 4)
' Output: (1, 6, 4)
' Example 3
' Input: @list = (0, 1, 0, 2, 0)
' Output: (1, 2, 0, 0, 0)

sub collect_args(nums() as integer)
    dim i as integer
    i=0
    do while command(i+1)<>""
        redim preserve nums(i) as integer
        nums(i)=val(command(i+1))
        i=i+1
    loop
end sub

sub print_nums(nums() as integer)
    dim i as integer

    for i=0 to ubound(nums)
        print nums(i);
    next
    print
end sub

sub move_zeros(nums() as integer)
    dim copy(ubound(nums)) as integer, i as integer, p as integer

    for i=0 to ubound(nums)
        copy(i)=nums(i)
    next
    p=0
    for i=0 to ubound(copy)
        if copy(i)<>0 then
            nums(p)=copy(i)
            p=p+1
        end if
    next
    for i=0 to ubound(copy)
        if copy(i)=0 then
            nums(p)=copy(i)
            p=p+1
        end if
    next
end sub

dim nums() as integer
collect_args nums()
move_zeros nums()
print_nums nums()
