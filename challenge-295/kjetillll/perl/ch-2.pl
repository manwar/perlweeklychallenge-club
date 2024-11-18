#https://theweeklychallenge.org/blog/perl-weekly-challenge-295/
#minimum number of jumps to hop forward from array index 0 to last element in @$allowed
#array where each element is the limit/max elements forward you can jump from there

use strict; use warnings; use List::Util 'min'; use Test::More tests => 3;

sub min_jumps {
    my( $allowed, $at, $jumps ) = ( @_, 0, 0 );
    $at >  $#$allowed ? -1
  : $at == $#$allowed ? $jumps
  : min(
        grep $_ > 0,
        map min_jumps( $allowed, $at + $_, $jumps + 1 ),
        1 .. $$allowed[$at]
    ) // -1
}

is pop(@$_) => min_jumps($_) for
[ 2, 3, 1, 1, 4 =>  2 ],
[ 2, 3, 0, 4    =>  2 ],
[ 2, 0, 0, 4    => -1 ];
