\ Challenge 089
\
\ TASK #1 › GCD Sum
\ Submitted by: Mohammad S Anwar
\ You are given a positive integer $N.
\
\ Write a script to sum GCD of all possible unique pairs between 1 and $N.
\
\ This solution uses a recursive algorithm to compute the GCD.
\
\ Start the script with N in the stack, i.e.
\   gforth -e 12345 ch-1.pl

: gcd       { a b -- gcd }
    a 0= IF
        b                   \ return b
    ELSE
        b a MOD  a  RECURSE \ recurse to return gcd(b MOD a, a)
    THEN
;

: sum_gcd   { n -- sum }
    0                       \ push initial sum
    n  1 ?DO                \ I: 1 .. n-1
        n 1+  I 1+ ?DO      \ J: I+1 .. n
            I J gcd +       \ accumulate gcd
        LOOP
    LOOP
;

sum_gcd . CR BYE
