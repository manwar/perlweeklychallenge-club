' Challenge 206
'
' Task 2: Array Pairings
' Submitted by: Mohammad S Anwar
'
' You are given an array of integers having even number of elements..
'
' Write a script to find the maximum sum of the minimum of each pairs.
' Example 1
'
' Input: @array = (1,2,3,4)
' Output: 4
'
' Possible Pairings are as below:
' a) (1,2) and (3,4). So min(1,2) + min(3,4) => 1 + 3 => 4
' b) (1,3) and (2,4). So min(1,3) + min(2,4) => 1 + 2 => 3
' c) (1,4) and (2,3). So min(1,4) + min(2,3) => 2 + 1 => 3
'
' So the maxium sum is 4.
'
' Example 2
'
' Input: @array = (0,2,1,3)
' Output: 2
'
' Possible Pairings are as below:
' a) (0,2) and (1,3). So min(0,2) + min(1,3) => 0 + 1 => 1
' b) (0,1) and (2,3). So min(0,1) + min(2,3) => 0 + 2 => 2
' c) (0,3) and (2,1). So min(0,3) + min(2,1) => 0 + 1 => 1
'
' So the maximum sum is 2.

' append number to list
sub push_elem(nums() as integer, n as integer)
    dim i as integer

    i=ubound(nums)
    redim preserve nums(i+1) as integer
    nums(i+1)=n
end sub

' remove number from list
sub del_elem(nums() as integer, idx as integer)
    dim i as integer

    for i=idx to ubound(nums)-1
        nums(i)=nums(i+1)
    next
    if ubound(nums)=0 then
        erase nums
    else
        redim preserve nums(ubound(nums)-1) as integer
    end if
end sub

' copy list
sub copy_list(src() as integer, dst() as integer)
    dim i as integer

    redim dst(ubound(src)) as integer
    for i=0 to ubound(src)
        dst(i)=src(i)
    next
end sub

' collect arguments
sub collect_args(nums() as integer)
    dim i as integer

    i=0
    do while command(i+1)<>""
        push_elem nums(),val(command(i+1))
        i=i+1
    loop
end sub

' compute maximum sum of minimum of each pair
sub compute_pairs_max(byref max as integer, set() as integer, pending() as integer)
    dim i as integer, j as integer, sum as integer, n as integer

    if ubound(pending)<0 then   ' compute sum, set max
        sum=0
        for i=0 to ubound(set) step 2
            if set(i)<set(i+1) then n=set(i) else n=set(i+1)
            sum=sum+n
        next
        if sum>max then max=sum
    else                        ' extract each pair and recurse
        for i=0 to ubound(pending)-1
            for j=i+1 to ubound(pending)
                dim new_set() as integer
                dim new_pending() as integer

                copy_list set(), new_set()
                push_elem new_set(), pending(i)
                push_elem new_set(), pending(j)

                copy_list pending(), new_pending()
                del_elem new_pending(), j
                del_elem new_pending(), i

                compute_pairs_max max, new_set(), new_pending()
            next
        next
    end if
end sub

dim empty() as integer, nums() as integer, max as integer
collect_args nums()
compute_pairs_max max, empty(), nums()
print max
