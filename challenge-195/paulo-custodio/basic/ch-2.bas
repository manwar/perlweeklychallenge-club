' Challenge 195
'
' Task 2: Most Frequent Even
' Submitted by: Mohammad S Anwar
' You are given a list of numbers, @list.
'
' Write a script to find most frequent even numbers in the list. In case you
' get more than one even numbers then return the smallest even integer. For all
' other case, return -1.
'
' Example 1
' Input: @list = (1,1,2,6,2)
' Output: 2 as there are only 2 even numbers 2 and 6 and of those 2 appears
' the most.
' Example 2
' Input: @list = (1,3,5,7)
' Output: -1 since no even numbers found in the list
' Example 3
' Input: @list = (6,4,4,6,1)
' Output: 4 since there are only two even numbers 4 and 6. They both appears
' the equal number of times, so pick the smallest.

sub collect_args(nums() as integer)
    dim i as integer
    i=0
    do while command(i+1)<>""
        redim preserve nums(i) as integer
        nums(i)=val(command(i+1))
        i=i+1
    loop
end sub

function most_freq_even(nums() as integer) as integer
    dim hist() as integer, i as integer, min_even as integer, max_count as integer
    for i=0 to ubound(nums)
        if nums(i)>ubound(hist) then redim preserve hist(nums(i)) as integer
        hist(nums(i))=hist(nums(i))+1
    next i
    min_even=-1
    max_count=0
    for i=0 to ubound(hist) step 2
        if hist(i)>max_count then
            max_count=hist(i)
            min_even=i
        end if
    next
    most_freq_even=min_even
end function

dim nums() as integer
collect_args nums()
print most_freq_even(nums())
