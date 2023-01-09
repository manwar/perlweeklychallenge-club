#!/usr/bin/env perl6

say &good-triplets( [3,0,1,1,9,7], 7,2,3); #4
say &good-triplets( [1,1,2,2,3], 0,0,1); #0

sub good-triplets( @array,$x,$y,$z ) {
    (0 .. @array-1)
        .combinations(3)
        .grep({abs(@array[@_[0]]-@array[@_[1]]) <= $x})
        .grep({abs(@array[@_[1]]-@array[@_[2]]) <= $y})
        .grep({abs(@array[@_[0]]=@array[@_[1]]) <= $z})
        .elems
}
