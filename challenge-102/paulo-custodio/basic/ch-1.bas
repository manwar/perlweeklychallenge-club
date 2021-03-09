' Challenge 102
'
' TASK #1 > Rare Numbers
' Submitted by: Mohammad S Anwar
'
' You are given a positive integer $N.
'
' Write a script to generate all Rare numbers of size $N if exists. Please
' checkout the page for more information about it.
' Examples
'
' (a) 2 digits: 65
' (b) 6 digits: 621770
' (c) 9 digits: 281089082

' convert 1234 to 4321
function invert_number(a as Integer) as Integer
    dim a1 as Integer
    do while a<>0
        a1 = a1*10 + (a mod 10)
        a = int(a / 10)
    loop
    invert_number = a1
end function

' check if number is a perfect square
function is_perfect_square(n as Integer) as Boolean
    dim sq as Double
    sq = sqr(CDbl(n))
    if int(sq)^2=n then
        is_perfect_square = True
    else
        is_perfect_square = False
    end if
end function

' print all rare numbers with n digits
sub print_rare_numbers(n as Integer)
    dim r as Integer, r1 as Integer
    for r=10^(n-1) to 10^(n)-1
        r1 = invert_number(r)
        if is_perfect_square(r+r1) then
            if r>=r1 then
                if is_perfect_square(r-r1) then
                    print trim(str(r))
                end if
            end if
        end if
    next
end sub

' main
print_rare_numbers val(Command(1))
