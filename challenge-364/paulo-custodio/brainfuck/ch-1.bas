' Perl Weekly Challenge 364 - Task 1 - solution by Paulo Custodio
' https://theweeklychallenge.org/blog/perl-weekly-challenge-364/

DIM word$(20)

end = 0
encode = 0
printed = 0

WHILE NOT end
    INPUT word$
    IF word$ = "" THEN
        end = 1
    ELSE
        IF word$ = "--" THEN    ' needed to be able to echp -- -e xxx
        ELSE
            IF word$ = "-e" THEN
                encode = 1
            ELSE
                IF encode THEN
                    print_encoded(word$)
                ELSE
                    print_decoded(word$)
                ENDIF
            ENDIF
        ENDIF
    ENDIF
WEND
PRINT

SUB print_encoded(word$)
    DIM c$(1), num$(3)
    IF printed THEN
        PRINT " ";
    ENDIF
    FOR i = 1 TO LEN(word$)
        c$ = MID$(word$, i, 1)
        IF c$ >= "a" AND c$ <= "z" THEN
            num$ = STR$(ASC(c$) - ASC("a") + 1)
            num$ = LEFT$(num$, LEN(num$) - 1)   ' remove space
            IF LEN(num$) > 1 THEN
                PRINT num$;"#";
            ELSE
                PRINT num$;
            ENDIF
        ENDIF
    NEXT
    printed = 1
ENDSUB

SUB print_decoded(word$)
    DIM c$(3)
    IF printed THEN
        PRINT " ";
    ENDIF
    FOR i = 1 TO LEN(word$)
        c$ = MID$(word$, i, 3)
        IF LEN(c$) = 3 AND RIGHT$(c$, 1) = "#" THEN
            PRINT CHR$(VAL(c$) + ASC("a") - 1);
            i = i + 2
        ELSE
            c$ = MID$(word$, i, 1)
            PRINT CHR$(VAL(c$) + ASC("a") - 1);
        ENDIF
    NEXT
    printed = 1
ENDSUB
