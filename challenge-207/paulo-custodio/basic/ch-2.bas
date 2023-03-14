' Challenge 207
'
' Task 2: H-Index
' Submitted by: Mohammad S Anwar
'
' You are given an array of integers containing citations a researcher has
' received for each paper.
'
' Write a script to compute the researcher’s H-Index. For more information
' please checkout the wikipedia page.
'
'     The H-Index is the largest number h such that h articles have at least h
'     citations each. For example, if an author has five publications,
'     with 9, 7, 6, 2, and 1 citations (ordered from greatest to least),
'     then the author’s h-index is 3, because the author has three publications
'     with 3 or more citations. However, the author does not have four
'     publications with 4 or more citations.
'
'
' Example 1
'
' Input: @citations = (10,8,5,4,3)
' Output: 4
'
' Because the 4th publication has 4 citations and the 5th has only 3.
'
' Example 2
'
' Input: @citations = (25,8,5,3,3)
' Output: 3
'
' The H-Index is 3 because the fourth paper has only 3 citations.

sub collect_args(nums() as integer)
    dim i as integer
    i=0
    do while command(i+1)<>""
        redim preserve nums(i) as integer
        nums(i)=val(command(i+1))
        i=i+1
    loop
end sub

sub rsort(mins() as integer)
    dim i as integer, j as integer, n as integer

    for i=lbound(mins) to ubound(mins)-1
        for j=i+1 to ubound(mins)
            if mins(i)<mins(j) then
                n=mins(i): mins(i)=mins(j): mins(j)=n
            end if
        next
    next
end sub

function h_index(nums() as integer) as integer
    dim i as integer
    for i=0 to ubound(nums)
        if nums(i)<i+1 then
            h_index=i+1-1
            exit function
        end if
    next
    h_index=-1
end function

dim nums() as integer
collect_args nums()
rsort nums()
print h_index(nums())
