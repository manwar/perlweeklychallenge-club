' Challenge 204
'
' Task 2: Reshape Matrix
' Submitted by: Mohammad S Anwar
'
' You are given a matrix (m x n) and two integers (r) and (c).
'
' Write a script to reshape the given matrix in form (r x c) with the original value in the given matrix. If you can’t reshape print 0.
'
' Example 1
'
' Input: [ 1 2 ]
'        [ 3 4 ]
'
'        $matrix = [ [ 1, 2 ], [ 3, 4 ] ]
'        $r = 1
'        $c = 4
'
' Output: [ 1 2 3 4 ]
'
' Example 2
'
' Input: [ 1 2 3 ]
'        [ 4 5 6 ]
'
'        $matrix = [ [ 1, 2, 3 ] , [ 4, 5, 6 ] ]
'        $r = 3
'        $c = 2
'
' Output: [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]
'
'         [ 1 2 ]
'         [ 3 4 ]
'         [ 5 6 ]
'
' Example 3
'
' Input: [ 1 2 ]
'
'        $matrix = [ [ 1, 2 ] ]
'        $r = 3
'        $c = 2
'
' Output: 0

dim nums() as integer
dim rows as integer, cols as integer

sub push_num(nums() as integer, n as integer)
    redim preserve nums(ubound(nums)+1) as integer
    nums(ubound(nums)) = n
end sub

sub remove_char(s as string, c as string)
    dim p as integer

    p=instr(s,c)
    do while p>0
        s=left(s,p-1)+" "+mid(s,p+1)
        p=instr(s,c)
    loop
end sub

function parse_number(byref s as string, byref n as integer) as boolean
    dim p as integer

    s=trim(s)
    if left(s,1)>="0" and left(s,1)<="9" then
        p=1
        do while mid(s,p,1)>="0" and mid(s,p,1)<="9"
            p=p+1
        loop
        n=val(left(s,p-1))
        s=mid(s,p+1)
        parse_number=true
    else
        parse_number=false
    end if
end function

function parse_line(nums() as integer, s as string) as boolean
    dim p as integer, n as integer

    s=trim(s)
    if left(s,1)="[" then
        remove_char s,"["
        remove_char s,"]"
        do while parse_number(s, n)
            push_num nums(), n
        loop
        parse_line=true
    else
        parse_line=false
    endif
end function

sub parse_input(nums() as integer, byref rows as integer, byref cols as integer)
    dim s as string

    open cons for input as #1
    line input #1,s
    do while parse_line(nums(), s)
        line input #1,s
    loop
    parse_number s,rows
    parse_number s,cols
end sub

sub print_matrix(nums() as integer, rows as integer, cols as integer)
    dim i as integer, j as integer

    if rows*cols=ubound(nums)+1 then
        for i=0 to rows-1
            print "[";
            for j=0 to cols-1
                print nums(i*cols+j);
            next
            print "]"
        next
    else
        print 0
    end if
end sub

parse_input nums(), rows, cols
print_matrix nums(), rows, cols
