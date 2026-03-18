' Perl Weekly Challenge 364 - Task 2 - solution by Paulo Custodio
' https://theweeklychallenge.org/blog/perl-weekly-challenge-364/

DIM word$(20)

end = 0
printed = 0

WHILE NOT end
    INPUT word$
    IF word$ = "" THEN
        end = 1
    ELSE
        IF word$ <> "--" THEN
            print_decoded(word$)
        ENDIF
    ENDIF
WEND
PRINT

SUB print_decoded(word$)
    DIM c$(3)
    IF printed THEN
        PRINT " ";
    ENDIF
    FOR i = 1 TO LEN(word$)
        IF MID$(word$, i, 1) <> """" THEN
            IF MID$(word$, i, 2) = "()" THEN
                PRINT "o";
                i = i + 1
            ELSE
                IF MID$(word$, i, 4) = "(al)" THEN
                    PRINT "al";
                    i = i + 3
                ELSE
                    PRINT MID$(word$, i, 1);
                ENDIF
            ENDIF
        ENDIF
    NEXT
    printed = 1
ENDSUB
