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
'
' NOTE: the  Wagner-Fischer Distance algorithm builds a table of distances
'       from which the operations can be deduced

const E as integer = 1
const S as integer = 2
const SE as integer = 3

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

sub wag_fish_dist(a as string, b as string)
    dim i as integer, j as integer, stp as integer, subst_cost as integer
    dim min_dr as integer, min_delta as integer, dr as integer, delta as integer

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
    print trim(str(d(len(a),len(b))))

    ' traverse the minimum path
    i = 0: j = 0
    do while i < len(a) or j < len(b)
        dr = 0: delta = 0: min_dr = 0: min_delta = len(a)+len(b)

        ' search shortest path in priority SE, E, S
        if i < len(a) and j < len(b) then
            dr = SE: delta = d(i+1,j+1) - d(i,j)
            min_dr = dr: min_delta = delta
        end if
        if j < len(b) then
            dr = E: delta = d(i,j+1) - d(i,j)
            if delta < min_delta then
                min_dr = dr: min_delta = delta
            end if
        end if
        if i < len(a) then
            dr = S: delta = d(i+1,j) - d(i,j)
            if delta < min_delta then
                min_dr = dr: min_delta = delta
            end if
        end if

        ' apply shortest path and show steps
        select case min_dr
        case SE
            i += 1: j += 1
            if mid(a,i,1) <> mid(b,j,1) then
                stp += 1
                print "Operation"; stp; ": replace '"; _
                      mid(a,i,1); "' with '"; mid(b,j,1); "'"
            end if
        case E
            j += 1
            stp += 1
            if j = len(b) then
                print "Operation"; stp; ": insert '"; _
                      mid(b,j,1); "' at end"
            else
                print "Operation"; stp; ": insert '"; _
                      mid(b,j,1); "' at position"; j
            end if
        case S
            i += 1
            stp += 1
            if i = len(a) then
                print "Operation"; stp; ": insert '"; _
                      mid(a,i,1); "' at end"
            else
                print "Operation"; stp; ": insert '"; _
                      mid(a,i,1); "' at position"; i
            end if
        case else
            assert(false)
        end select
    loop
end sub


wag_fish_dist command(1), command(2)
