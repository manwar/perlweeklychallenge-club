' Perl Weekly Challenge 366 - Task 2 - solution by Paulo Custodio
' https://theweeklychallenge.org/blog/perl-weekly-challenge-366/

DIM dashdash$(2), pat$(5)

INPUT dashdash$
IF dashdash$ = "--" THEN
    INPUT pat$
ELSE
    pat$ = dashdash$
ENDIF

PRINT count_minutes(pat$)

FUNCTION count_minutes(pat$)
    DIM h1$(1), h2$(1), m1$(1), m2$(1)

    IF LEN(pat$) <> 5 OR MID$(pat$,3,1) <> ":" THEN
        count_minutes = 0
    ELSE
        h1$ = MID$(pat$,1,1)
        h2$ = MID$(pat$,2,1)
        m1$ = MID$(pat$,4,1)
        m2$ = MID$(pat$,5,1)

        IF h1$ = "?" And h2$ = "?" THEN
            hours = 24
        ELSE
            IF h1$ = "?" THEN
                IF h2$ <= "9" THEN hours = hours + 2
                IF h2$ <= "3" THEN hours = hours + 1
            ELSE
                IF h2$ = "?" THEN
                    IF h1$ = "0" OR h1$ = "1" THEN hours = 10 ELSE hours = 4
                ELSE
                    IF Val(pat$) <= 23 THEN hours = 1 ELSE hours = 0
                ENDIF
            ENDIF
        ENDIF

        IF m1$ = "?" THEN minutes = 6 ELSE minutes = 1
        IF m2$ = "?" THEN minutes = minutes * 10

        count_minutes = hours * minutes
    ENDIF
ENDFUNCTION
