' Perl Weekly Challenge 366 - Task 1 - solution by Paulo Custodio
' https://theweeklychallenge.org/blog/perl-weekly-challenge-366/

DIM dashdash$(2), word$(10), prefix$(10)

INPUT dashdash$
IF dashdash$ = "--" THEN
    INPUT word$
ELSE
    word$ = dashdash$
ENDIF

count = 0
INPUT prefix$
WHILE prefix$ <> ""
    IF LEN(word$) >= LEN(prefix$) THEN
        IF prefix$ = LEFT$(word$, LEN(prefix$)) THEN
            count= count + 1
        ENDIF
    ENDIF
    INPUT prefix$
WEND

PRINT count
