' Challenge 200
'
' Task 2: Seven Segment 200
' Submitted by: Ryan J Thompson
' A seven segment display is an electronic component, usually used to display
' digits. The segments are labeled 'a' through 'g' as shown:
'
'
' Seven Segment
'
'
' The encoding of each digit can thus be represented compactly as a truth table:
'
' my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;
' For example, $truth[1] = ‘bc’. The digit 1 would have segments ‘b’ and ‘c’ enabled.
'
' Write a program that accepts any decimal number and draws that number as a
' horizontal sequence of ASCII seven segment displays, similar to the following:
'
'
' -------  -------  -------
'       |  |     |  |     |
'       |  |     |  |     |
' -------
' |        |     |  |     |
' |        |     |  |     |
' -------  -------  -------
' To qualify as a seven segment display, each segment must be drawn (or not drawn)
' according to your @truth table.
'
' The number "200" was of course chosen to celebrate our 200th week!

const a as integer = 1
const b as integer = 2
const c as integer = 4
const d as integer = 8
const e as integer = 16
const f as integer = 32
const g as integer = 64

dim shared truth(9) as integer
truth(0)=a+b+c+d+e+f
truth(1)=b+c
truth(2)=a+b+d+e+g
truth(3)=a+b+c+d+g
truth(4)=b+c+f+g
truth(5)=a+c+d+f+g
truth(6)=a+c+d+e+f+g
truth(7)=a+b+c
truth(8)=a+b+c+d+e+f+g
truth(9)=a+b+c+f+g

sub draw_number(n as integer)
    dim s as string, i as integer, j as integer, digit as integer

    s=trim(str(n))

    ' draw a
    for i=1 to len(s)
        digit=val(mid(s,i,1))
        if (truth(digit) and a)=a then print " ####   "; else print "        ";
    next
    print
    ' draw f, b
    for j=1 to 2
        for i=1 to len(s)
            digit=val(mid(s,i,1))
            if (truth(digit) and f)=f then print "#"; else print " ";
            print "    ";
            if (truth(digit) and b)=b then print "#"; else print " ";
            print "  ";
        next
        print
    next
    ' draw g
    for i=1 to len(s)
        digit=val(mid(s,i,1))
        if (truth(digit) and g)=g then print " ####   "; else print "        ";
    next
    print
    ' draw e, c
    for j=1 to 2
        for i=1 to len(s)
            digit=val(mid(s,i,1))
            if (truth(digit) and e)=e then print "#"; else print " ";
            print "    ";
            if (truth(digit) and c)=c then print "#"; else print " ";
            print "  ";
        next
        print
    next
    ' draw d
    for i=1 to len(s)
        digit=val(mid(s,i,1))
        if (truth(digit) and d)=d then print " ####   "; else print "        ";
    next
    print
end sub

draw_number(val(command(1)))
