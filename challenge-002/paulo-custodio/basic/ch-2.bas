' Challenge 002
'
' Challenge #2
' Write a script that can convert integers to and from a base35
' representation, using the characters 0-9 and A-Y. Dave Jacoby came up
' with nice description about base35, in case you needed some background.

function format_digit(n as integer) as string
    if n<10 then
        format_digit = chr(n+asc("0"))
    else
        format_digit = chr(n+asc("A")-10)
    end if
end function

function format_number(n as integer, radix as integer) as string
    dim negative as boolean, text as string, d as integer
    if n<0 then
        negative = true
        n = -n
    end if
    do
        d = n mod radix
        n = int(n / radix)
        text = format_digit(d) & text
    loop while n > 0
    if negative then
        text = "-" & text
    end if
    format_number = text
end function

function scan_digit(c as string) as integer
    if c >= "0" and c < "9" then
        scan_digit = asc(c)-asc("0")
    elseif ucase(c) >= "A" and ucase(c) <= "Z" then
        scan_digit = asc(ucase(c))-asc("A")+10
    else
        scan_digit = -1
    end if
end function

function scan_number(text as string, radix as integer) as integer
    dim negative as boolean, n as integer, i as integer, d as integer
    if left(text,1) = "-" then
        negative = true
        text = mid(text, 2)
    end if
    for i=1 to len(text)
        d = scan_digit(mid(text,i,1))
        if d < 0 or d >= radix then
            print "invalid number"
            end
        end if
        n = n*radix + d
    next i
    if negative then
        n = -n
    end if
    scan_number = n
end function


' main
if command(1) = "-r" then
    print scan_number(command(2), 35)
else
    print format_number(val(command(1)), 35)
end if
