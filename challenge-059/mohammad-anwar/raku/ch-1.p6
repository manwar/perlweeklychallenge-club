#!/usr/bin/env perl6

use v6.d;

sub MAIN($L = [ 1, 4, 3, 2, 5, 2 ], $K = 3) {

    my $O = split-list($L, $K);
    say sprintf("Input:  [ %s ]", $L.join(" -> "));
    say sprintf("Output: [ %s ]", $O.join(" -> "));
}

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
