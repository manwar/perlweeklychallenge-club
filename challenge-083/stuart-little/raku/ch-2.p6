#!/usr/bin/env perl6
use v6;

sub cmpair($cap) {
    return -> @a, @b {
	(@b.sum <= $cap) ?? max(@a,(@b.sum,-@b.elems)) !! @a;
    }
}

say -reduce(cmpair(@*ARGS.sum/2), (0,0), |@*ARGS.combinations).[1];

# run as <script> <list of input integers separated by spaces>
