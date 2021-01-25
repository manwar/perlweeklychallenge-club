#! /usr/bin/env gforth

\ Challenge 089
\
\ TASK #2 › Magical Matrix
\ Submitted by: Mohammad S Anwar
\ Write a script to display matrix as below with numbers 1 - 9.
\ Please make sure numbers are used once.
\
\ [ a b c ]
\ [ d e f ]
\ [ g h i ]
\ So that it satisfies the following:
\
\ a + b + c = 15
\ d + e + f = 15
\ g + h + i = 15
\ a + d + g = 15
\ b + e + h = 15
\ c + f + i = 15
\ a + e + i = 15
\ c + e + g = 15

\ Test a brute-force method; for a better algorithm see my perl solution.

: solve
  1 2 3 4 5 6 7 8 9 { a b c d e f g h i }   \ create 9 local variables
  0 TO a BEGIN a 1+ TO a  a 10 < WHILE
    0 TO b BEGIN b 1+ TO b  b 10 < WHILE
      b a <> IF
        0 TO c BEGIN c 1+ TO c  c 10 < WHILE
          c a <>  c b <>  AND IF
            0 TO d BEGIN d 1+ TO d  d 10 < WHILE
              d a <>  d b <>  d c <>  AND AND IF
                0 TO e BEGIN e 1+ TO e  e 10 < WHILE
                  e a <>  a b <>  e c <>  e d <> AND AND AND IF
                    0 TO f BEGIN f 1+ TO f  f 10 < WHILE
                      f a <>  f b <>  f c <>  f d <>  f e <> AND AND AND AND IF
                        0 TO g BEGIN g 1+ TO g  g 10 < WHILE
                          g a <>  g b <>  g c <>  g d <>  g e <>  g f <>
                          AND AND AND AND AND IF
                            0 TO h BEGIN h 1+ TO h  h 10 < WHILE
                              h a <>  h b <>  h c <>  h d <>  h e <>  h f <>  h g <>
                              AND AND AND AND AND AND IF
                                0 TO i BEGIN i 1+ TO i  i 10 < WHILE
                                  i a <>  i b <>  i c <>  i d <>
                                  i e <>  i f <>  i g <>  i h <>
                                  AND AND AND AND AND AND AND IF
                                    a b c + + 15 = IF
                                      d e f + + 15 = IF
                                        g h i + + 15 = IF
                                          a d g + + 15 = IF
                                            b e h + + 15 = IF
                                              c f i + + 15 = IF
                                                a e i + + 15 = IF
                                                  c e g + + 15 = IF
                                                    ." [ " a . b . c . ." ]" CR
                                                    ." [ " d . e . f . ." ]" CR
                                                    ." [ " g . h . i . ." ]" CR
                                                    EXIT
                                                  THEN
                                                THEN
                                              THEN
                                            THEN
                                          THEN
                                        THEN
                                      THEN
                                    THEN
                                  THEN
                                REPEAT
                              THEN
                            REPEAT
                          THEN
                        REPEAT
                      THEN
                    REPEAT
                  THEN
                REPEAT
              THEN
            REPEAT
          THEN
        REPEAT
      THEN
    REPEAT
  REPEAT
;

solve BYE
