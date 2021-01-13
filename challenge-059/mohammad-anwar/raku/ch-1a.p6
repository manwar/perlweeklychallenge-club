#!/usr/bin/env perl6

use Test;

is-deeply split-list([ 1, 4, 3, 2, 5, 2 ], 3), [ 1, 2, 2, 4, 3, 5 ];

done-testing;

sub split-list($L, $K) {

    my $before = [];
    my $after  = [];
    for |$L -> $i {
        if $i < $K {
            $before.push: $i;
        }
        else {
            $after.push: $i;
        }
    }

    return [ |$before, |$after ];
}
