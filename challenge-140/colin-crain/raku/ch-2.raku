#!/usr/bin/env perl6
#
#
#       multi-pass.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $m = 6, Int $n = 5, $idx = 6) ;

((1..$m X* 1..$n).sort)[$idx].say ;
