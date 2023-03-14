' Challenge 203
'
' Task 1: Special Quadruplets
' Submitted by: Mohammad S Anwar
'
' You are given an array of integers.
'
' Write a script to find out the total special quadruplets for the given array.
'
' Special Quadruplets are such that satisfies the following 2 rules.
' 1) nums[a] + nums[b] + nums[c] == nums[d]
' 2) a < b < c < d
'
'
' Example 1
'
' Input: @nums = (1,2,3,6)
' Output: 1
'
' Since the only special quadruplets found is
' $nums[0] + $nums[1] + $nums[2] == $nums[3].
'
' Example 2
'
' Input: @nums = (1,1,1,3,5)
' Output: 4
'
' $nums[0] + $nums[1] + $nums[2] == $nums[3]
' $nums[0] + $nums[1] + $nums[3] == $nums[4]
' $nums[0] + $nums[2] + $nums[3] == $nums[4]
' $nums[1] + $nums[2] + $nums[3] == $nums[4]
'
' Example 3
'
' Input: @nums = (3,3,6,4,5)
' Output: 0

function num_quadruplets(nums() as integer) as integer
    dim count as integer, a as integer, b as integer, c as integer, d as integer
    count=0
    for a=0 to ubound(nums)-3
        for b=a+1 to ubound(nums)-2
            for c=b+1 to ubound(nums)-1
                for d=c+1 to ubound(nums)
                    if nums(a)+nums(b)+nums(c)=nums(d) then
                        count=count+1
                    end if
                next
            next
        next
    next
    num_quadruplets=count
end function

sub collect_args(nums() as integer)
    dim i as integer
    i=0
    do while command(i+1)<>""
        redim preserve nums(i) as integer
        nums(i)=val(command(i+1))
        i=i+1
    loop
end sub

dim nums() as integer
collect_args nums()
print num_quadruplets(nums())
