! Copyright (C) 2025 Your name.
! See https://factorcode.org/license.txt for BSD license.
USING: grouping kernel math prettyprint sequences sets.extras sorting ;
IN: 351part2


: clumps ( a -- a ) sort 2 clump   ;

: arith ( a -- a ) 0 [ swap - ] accumulate drop ;
: arithprog? ( a -- a ) clumps [ arith ] map non-repeating length 0 = ;
