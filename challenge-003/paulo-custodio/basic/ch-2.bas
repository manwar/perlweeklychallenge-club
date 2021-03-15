' Challenge 003
'
' Challenge #2
' Create a script that generates Pascal Triangle. Accept number of rows from
' the command line. The Pascal Triangle should have at least 3 rows. For more
' information about Pascal Triangle, check this wikipedia page.

sub draw_pascal(rows as integer)
    dim n(1, rows) as integer
    dim cur as integer, row as integer, col as integer

    cur = 0
    n(cur, 0) = 1
    for row=1 to rows
        ' print current row
        print space(rows-row);
        for col=0 to row-1: print trim(str(n(cur,col)));" ";: next col: print

        ' compute next row
        n(1-cur, 0) = 1: n(1-cur,row) = 1
        for col=1 to row-1: n(1-cur,col) = n(cur,col-1)+n(cur,col): next col
        cur = 1-cur
    next row
end sub

draw_pascal val(command(1))
