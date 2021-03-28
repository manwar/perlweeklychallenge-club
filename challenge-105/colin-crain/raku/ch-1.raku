#!/usr/bin/env perl6
#
#
#       nth-root.raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN (Int $n = 3, Int $x = 125) ;

.fmt("%2.2f").say for nroot($n, $x);


sub nroot( Int $n, Int $x where { $x > 0 } ) {
    return exp( (log $x) / $n );
}
