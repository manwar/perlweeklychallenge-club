#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $limit = 1000) ;

say gather for 1..* -> $x {
    my $n = 3 * $x² + 3 * $x + 1;
    last if $n > $limit;
    take $n if $n.is-prime;
}
