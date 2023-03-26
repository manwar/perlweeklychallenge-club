' Challenge 197
'
' Task 1: Pattern 132
' Submitted by: Mohammad S Anwar
' You are given a list of integers, @list.
'
' Write a script to find out subsequence that respect Pattern 132. Return empty array if none found.
'
'
' Pattern 132 in a sequence (a[i], a[j], a[k]) such that i < j < k and a[i] < a[k] < a[j].
'
'
' Example 1
' Input:  @list = (3, 1, 4, 2)
' Output: (1, 4, 2) respect the Pattern 132.
' Example 2
' Input: @list = (1, 2, 3, 4)
' Output: () since no susbsequence can be found.
' Example 3
' Input: @list = (1, 3, 2, 4, 6, 5)
' Output: (1, 3, 2) if more than one subsequence found then return the first.
' Example 4
' Input: @list = (1, 3, 4, 2)
' Output: (1, 3, 2)

sub collect_args(nums() as integer)
    dim i as integer
    i=0
    do while command(i+1)<>""
        redim preserve nums(i) as integer
        nums(i)=val(command(i+1))
        i=i+1
    loop
end sub

sub print_pattern132(nums() as integer)
    dim i as integer, j as integer, k as integer
    for i=0 to ubound(nums)-2
        for j=i+1 to ubound(nums)-1
            for k=j+1 to ubound(nums)
                if nums(i)<nums(k) and nums(k)<nums(j) then
                    print "(";nums(i);nums(j);nums(k);")"
                    exit sub
                end if
            next
        next
    next
    print "()"
end sub

dim nums() as integer
collect_args nums()
print_pattern132 nums()
