#! /usr/bin/env gforth

\ Challenge 200
\
\ Task 2: Seven Segment 200
\ Submitted by: Ryan J Thompson
\ A seven segment display is an electronic component, usually used to display
\ digits. The segments are labeled 'a' through 'g' as shown:
\
\
\ Seven Segment
\
\
\ The encoding of each digit can thus be represented compactly as a truth table:
\
\ my @truth = qw<abcdef bc abdeg abcdg bcfg acdfg acdefg abc abcdefg abcfg>;
\ For example, $truth[1] = ‘bc’. The digit 1 would have segments ‘b’ and ‘c’ enabled.
\
\ Write a program that accepts any decimal number and draws that number as a
\ horizontal sequence of ASCII seven segment displays, similar to the following:
\
\
\ -------  -------  -------
\       |  |     |  |     |
\       |  |     |  |     |
\ -------
\ |        |     |  |     |
\ |        |     |  |     |
\ -------  -------  -------
\ To qualify as a seven segment display, each segment must be drawn (or not drawn)
\ according to your @truth table.
\
\ The number "200" was of course chosen to celebrate our 200th week!

1  CONSTANT A
2  CONSTANT B
4  CONSTANT C
8  CONSTANT D
16 CONSTANT E
32 CONSTANT F
64 CONSTANT G

: | OR ;

CREATE truth
A B | C | D | E | F | ,
B C | ,
A B | D | E | G | ,
A B | C | D | G | ,
B C | F | G | ,
A C | D | F | G | ,
A C | D | E | F | G | ,
A B | C | ,
A B | C | D | E | F | G | ,
A B | C | F | G | ,

: has_segment { n seg -- f }
    n 10 MOD CELLS truth + @  seg AND  seg =
;

: num_to_str ( n -- addr size )
    0 <# #S #>
;

: digit_mask ( c -- mask )
    '0' - CELLS truth + @
;

: draw_horizontal { num size mask -- }
    num size BOUNDS DO
        I C@ digit_mask mask AND mask = IF ."  #### " ELSE 6 SPACES THEN
        2 SPACES
    LOOP
    CR
;

: draw_vertical { num size mask1 mask2 }
    2 0 DO
        num size BOUNDS DO
            I C@ digit_mask
            DUP mask1 AND mask1 = IF '#' EMIT ELSE SPACE THEN
            4 SPACES
            mask2 AND mask2 = IF '#' EMIT ELSE SPACE THEN
            2 SPACES
        LOOP
        CR
    LOOP
;

: draw_a ( num size -- )
    A draw_horizontal
;

: draw_f_b ( num size -- )
    F B draw_vertical
;

: draw_g ( num size -- )
    G draw_horizontal
;

: draw_e_c ( num size -- )
    E C draw_vertical
;

: draw_d ( num size -- )
    D draw_horizontal
;

: draw_number ( n -- )
    num_to_str { num size }
    num size draw_a
    num size draw_f_b
    num size draw_g
    num size draw_e_c
    num size draw_d
;


NEXT-ARG S>NUMBER? 0= THROW DROP
draw_number
BYE
