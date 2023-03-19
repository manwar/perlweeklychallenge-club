' Challenge 198
'
' Task 1: Max Gap
' Submitted by: Mohammad S Anwar
' You are given a list of integers, @list.
'
' Write a script to find the total pairs in the sorted list where 2 consecutive
' elements has the max gap. If the list contains less then 2 elements then
' return 0.
'
'
' Example 1
' Input:  @list = (2,5,8,1)
' Output: 2
'
' Since the sorted list (1,2,5,8) has 2 such pairs (2,5) and (5,8)
' Example 2
' Input: @list = (3)
' Output: 0

sub collect_args(nums() as integer)
    dim i as integer
    i=0
    do while command(i+1)<>""
        redim preserve nums(i) as integer
        nums(i)=val(command(i+1))
        i=i+1
    loop
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

function max_gap(nums() as integer) as integer
    dim cur_gap as integer, gap_count as integer, gap as integer, i as integer
    cur_gap=0: gap_count=0
    sort nums()
    for i=0 to ubound(nums)-1
        gap=nums(i+1)-nums(i)
        if gap>cur_gap then
            cur_gap=gap
            gap_count=1
        elseif gap=cur_gap then
            gap_count=gap_count+1
        end if
    next
    max_gap=gap_count
end function

dim nums() as integer
collect_args nums()
print max_gap(nums())
