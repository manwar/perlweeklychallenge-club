#!/usr/bin/env -S perl -wl

use strict;
use Algorithm::Combinatorics qw(combinations);

print &good_triplets( 7,2,3, 3,0,1,1,9,7); #4
print &good_triplets( 0,0,1, 1,1,2,2,3); #0

sub good_triplets {
    my ($x,$y,$z,@array)=@_;

    scalar( 
    grep {abs($array[$_->[0]]-$array[$_->[2]]) <= $z}
    grep {abs($array[$_->[1]]-$array[$_->[2]]) <= $y}
    grep {abs($array[$_->[0]]-$array[$_->[1]]) <= $x}
    combinations [0 .. @array-1], 3 );    
}
