' Challenge 199
'
' Task 2: Good Triplets
' Submitted by: Mohammad S Anwar
'
' You are given an array of integers, @array and three integers $x,$y,$z.
'
' Write a script to find out total Good Triplets in the given array.
'
' A triplet array[i], array[j], array[k] is good if it satisfies the following
' conditions:
'
' a) 0 <= i < j < k <= n (size of given array)
' b) abs(array[i] - array[j]) <= x
' c) abs(array[j] - array[k]) <= y
' d) abs(array[i] - array[k]) <= z
'
' Example 1
'
' Input: @array = (3,0,1,1,9,7) and $x = 7, $y = 2, $z = 3
' Output: 4
'
' Good Triplets are as below:
' (3,0,1) where (i=0, j=1, k=2)
' (3,0,1) where (i=0, j=1, k=3)
' (3,1,1) where (i=0, j=2, k=3)
' (0,1,1) where (i=1, j=2, k=3)
'
' Example 2
'
' Input: @array = (1,1,2,2,3) and $x = 0, $y = 0, $z = 1
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

function pop(nums() as integer) as integer
    pop=nums(ubound(nums))
    redim preserve nums(ubound(nums)-1)
end function

function count_good_triplets(nums() as integer, _
            x as integer, y as integer, z as integer) as integer
    dim count as integer, i as integer, j as integer, k as integer
    count=0
    for i=0 to ubound(nums)-2
        for j=i+1 to ubound(nums)-1
            for k=j+1 to ubound(nums)
                if abs(nums(i) - nums(j)) <= x and _
                   abs(nums(j) - nums(k)) <= y and _
                   abs(nums(i) - nums(k)) <= z then
                    count=count+1
                end if
            next
        next
    next
    count_good_triplets=count
end function

dim nums() as integer, x as integer, y as integer, z as integer
collect_args nums()
z=pop(nums())
y=pop(nums())
x=pop(nums())
print count_good_triplets(nums(), x, y, z)
