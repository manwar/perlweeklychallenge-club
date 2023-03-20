' Challenge 208
'
' Task 1: Minimum Index Sum
' Submitted by: Mohammad S Anwar
'
' You are given two arrays of strings.
'
' Write a script to find out all common strings in the given two arrays with
' minimum index sum. If no common strings found returns an empty list.
' Example 1
'
' Input: @list1 = ("Perl", "Raku", "Love")
'        @list2 = ("Raku", "Perl", "Hate")
'
' Output: ("Perl", "Raku")
'
' There are two common strings "Perl" and "Raku".
' Index sum of "Perl": 0 + 1 = 1
' Index sum of "Raku": 1 + 0 = 1
'
' Example 2
'
' Input: @list1 = ("A", "B", "C")
'        @list2 = ("D", "E", "F")
'
' Output: ()
'
' No common string found, so no result.
'
' Example 3
'
' Input: @list1 = ("A", "B", "C")
'        @list2 = ("C", "A", "B")
'
' Output: ("A")
'
' There are three common strings "A", "B" and "C".
' Index sum of "A": 0 + 1 = 1
' Index sum of "B": 1 + 2 = 3
' Index sum of "C": 2 + 0 = 2

sub collect_args(list1() as string, list2() as string)
    dim args() as string, i as integer, n as integer
    i=0
    do while command(i+1)<>""
        redim preserve args(i)
        args(i)=command(i+1)
        i=i+1
    loop
    n=int((ubound(args)+1)/2)
    redim list1(n-1) as string
    redim list2(n-1) as string
    for i=0 to n-1
        list1(i)=args(i)
        list2(i)=args(n+i)
    next
end sub

sub common_strings(list1() as string, list2() as string, comm() as string)
    dim i as integer, j as integer, min_index as integer, n as integer
    erase comm
    min_index=ubound(list1)+ubound(list2)+1
    for i=0 to ubound(list1)
        for j=0 to ubound(list2)
            if list1(i)=list2(j) then
                if i+j<min_index then
                    redim preserve comm(0) as string
                    comm(0)=list1(i)
                    min_index=i+j
                elseif i+j=min_index then
                    n=ubound(comm)+1
                    redim preserve comm(n) as string
                    comm(n)=list1(i)
                    min_index=i+j
                end if
            end if
        next
    next
end sub



dim list1() as string, list2() as string, comm() as string, i as integer
collect_args list1(), list2()
common_strings list1(), list2(), comm()
if ubound(comm)=-1 then
    print "()"
else
    for i=0 to ubound(comm): print comm(i);" ";: next: print
end if
