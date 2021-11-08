#!/usr/bin/env perl6
#
#
#       121-that-ones-upside-down.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( Int $num, Int $pos ) ;


say $num +^ 2**($pos-1);
