' Perl Weekly Challenge 365 - Task 1 - solution by Paulo Custodio
' https://theweeklychallenge.org/blog/perl-weekly-challenge-365/

DIM dash$(2), word$(10), digits$(10)

INPUT dash$, word$, k

' convert to digits
DIM num$(4)
FOR i = 1 TO LEN(word$)
    c = ASC(MID$(word$, i, 1)) - ASC("a") + 1
    num$ = STR$(c)
    num$ = LEFT$(num$, LEN(num$)-1)     ' remove space
    digits$ = digits$ & num$
NEXT i

' compute sum k times
FOR i = 1 TO k
    sum = compute_sum(digits$)
    digits$ = STR$(sum)
    digits$ = LEFT$(digits$, LEN(digits$)-1)
NEXT i

PRINT sum

FUNCTION compute_sum(digits$)
    sum = 0
    FOR j = 1 TO LEN(digits$)
        c = ASC(MID$(digits$, j, 1)) - ASC("0")
        IF c >= 0 AND c <= 9 THEN
            sum = sum + c
        ENDIF
    NEXT j

    compute_sum = sum
ENDFUNCTION
