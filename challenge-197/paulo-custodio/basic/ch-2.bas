' Challenge 197
'
' Task 2: Wiggle Sort
' Submitted by: Mohammad S Anwar
' You are given a list of integers, @list.
'
' Write a script to perform Wiggle Sort on the given list.
'
'
' Wiggle sort would be such as list[0] < list[1] > list[2] < list[3]….
'
'
' Example 1
' Input: @list = (1,5,1,1,6,4)
' Output: (1,6,1,5,1,4)
' Example 2
' Input: @list = (1,3,2,2,3,1)
' Output: (2,3,1,3,1,2)

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

sub sort(nums() as integer)
    dim i as integer, j as integer, n as integer

    for i=lbound(nums) to ubound(nums)-1
        for j=i+1 to ubound(nums)
            if nums(i)>nums(j) then
                n=nums(i): nums(i)=nums(j): nums(j)=n
            end if
        next
    next
end sub

sub copy_data(dst() as integer, dst_idx as integer, from() as integer, from_idx as integer)
    do while dst_idx>=0
        dst(dst_idx)=from(from_idx)
        dst_idx=dst_idx-2
        from_idx=from_idx+1
    loop
end sub

sub wiggle_sort(nums() as integer)
    dim i as integer, j as integer, copy(ubound(nums)) as integer

    for i=0 to ubound(nums)
        copy(i)=nums(i)
    next
    sort copy()

    copy_data nums(), ubound(nums)-1, copy(), 0
    copy_data nums(), ubound(nums), copy(), (ubound(nums)+1)/2
end sub

dim nums() as integer
collect_args nums()
wiggle_sort nums()
print_nums nums()
