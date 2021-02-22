' Challenge 096
'
' TASK #2 › Edit Distance
' Submitted by: Mohammad S Anwar
' You are given two strings $S1 and $S2.
'
' Write a script to find out the minimum operations required to convert $S1
' into $S2. The operations can be insert, remove or replace a character. Please
' check out Wikipedia page for more information.
'
' Example 1:
' Input: $S1 = "kitten"; $S2 = "sitting"
' Output: 3
'
' Operation 1: replace 'k' with 's'
' Operation 2: replace 'e' with 'i'
' Operation 3: insert 'g' at the end
' Example 2:
' Input: $S1 = "sunday"; $S2 = "monday"
' Output: 2
'
' Operation 1: replace 's' with 'm'
' Operation 2: replace 'u' with 'o'

function min(a as integer, b as integer) as integer
    if a < b then
        min = a
    else
        min = b
    end if
end function

function min3(a as integer, b as integer, c as integer) as integer
    min3 = min(a, min(b, c))
end function

function wag_fish_dist(a as string, b as string) as integer
    dim i as integer, j as integer, subst_cost as integer

    ' define a table where d(i,j) is the Levenshtein distance between
    ' first i chars of a and first j chars of b
    dim d(len(a)+1, len(b)+1) as integer

    ' source prefixes can be transformed into empty string by dropping chars
    for i = 1 to len(a)
        d(i,0) = i
    next i

    ' target prefixes can be reached from empty source prefix by inserting chars
    for j = 1 to len(b)
        d(0,j) = j
    next j

    ' flood-fill the rest of the table
    for j = 1 to len(b)
        for i = 1 to len(a)
            if mid(a,i,1) = mid(b,j,1) then
                subst_cost = 0
            else
                subst_cost = 1
            end if
            d(i,j) = min3(d(i-1,j)+1,           _   ' deletion
                          d(i,j-1)+1,           _   ' insertion
                          d(i-1,j-1)+subst_cost)    ' substitution
        next i
    next j

    ' distance is in lower bottom cell
    wag_fish_dist = d(len(a), len(b))
end function

print trim(str(wag_fish_dist(command(1), command(2))))
