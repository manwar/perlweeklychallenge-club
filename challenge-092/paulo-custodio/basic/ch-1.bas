' Challenge 092
'
' TASK #1 › Isomorphic Strings
' Submitted by: Mohammad S Anwar
' You are given two strings $A and $B.
'
' Write a script to check if the given strings are Isomorphic. Print 1 if they
' are otherwise 0.
'
' Example 1:
' Input: $A = "abc"; $B = "xyz"
' Output: 1
' Example 2:
' Input: $A = "abb"; $B = "xyy"
' Output: 1
' Example 3:
' Input: $A = "sum"; $B = "add"
' Output: 0

function isomorphic(a as string, b as string) as integer
    dim mapping(256) as integer, mapped(256) as integer
    dim i as integer, ac as integer, bc as integer

    if a="" or len(a)<>len(b) then
        isomorphic = 0: exit function
    end if

    for i=1 to len(a)
        ac = asc(mid(a,i,1))
        bc = asc(mid(b,i,1))
        if mapping(ac)=0 then           ' a is new
            if mapped(bc)<>0 then       ' b already mapped to some other a
                isomorphic = 0: exit function
            else                        ' store mapping
                mapping(ac) = bc
                mapped(bc) = 1
            end if
        else                            ' a already occurred
            if mapping(ac)<>bc then     ' previous mapping is different
                isomorphic = 0: exit function
            end if
        end if
    next
    isomorphic = 1
end function

print isomorphic(command(1), command(2))
