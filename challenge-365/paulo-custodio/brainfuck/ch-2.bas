' Perl Weekly Challenge 365 - Task 2 - solution by Paulo Custodio
' https://theweeklychallenge.org/blog/perl-weekly-challenge-365/

FUNCTION is_letter(c$)
    is_letter = c$ >= "a" AND c$ <= "z"
ENDFUNCTION

FUNCTION is_punct(c$)
    is_punct = c$ = "!" OR c$ = "." OR c$ = ","
ENDFUNCTION

FUNCTION is_valid(text$)
    DIM c$(1), p$(1), n$(1)

    has_hiffen = 0
    is_valid = 1
    FOR i = 1 TO LEN(text$)
        c$ = MID$(text$, i, 1)
        IF is_letter(c$) THEN
            ' ok
        ELSE
            IF c$ = "-" THEN
                IF has_hiffen THEN
                    is_valid = 0
                ENDIF
                has_hiffen = 1

                IF i = 1 OR i = LEN(text$) THEN
                    is_valid = 0
                ENDIF

                p$ = MID$(text$, i-1, 1)
                n$ = MID$(text$, i+1, 1)

                IF NOT is_letter(p$) OR NOT is_letter(n$) THEN
                    is_valid = 0
                ENDIF
            ELSE
                IF is_punct(c$) AND i = LEN(text$) THEN
                    ' ok
                ELSE
                    is_valid = 0
                ENDIF
            ENDIF
        ENDIF
    NEXT i
ENDFUNCTION

DIM word$(20)

INPUT word$ ' --

count = 0
INPUT word$
WHILE word$ <> ""
    IF is_valid(word$) THEN
        count = count + 1
    ENDIF
    INPUT word$
WEND
PRINT count
