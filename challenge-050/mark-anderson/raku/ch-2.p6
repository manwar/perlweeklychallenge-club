#!/usr/bin/env perl6

use Test;

plan 7;

is noble((1 .. 8)),                     4, "(1 .. 8) = 4";
is noble((1, 6, 3, 2)),                 2, "(1, 6, 3, 2) = 2";
is noble((3, 5, 5, 5, 5)),             (), "(3, 5, 5, 5, 5) = ()";
is noble((4, 5, 5, 5, 5)),              4, "(4, 5, 5, 5, 5) = 4";
is noble((1, 5, 5, 2, 3, 6)),           3, "(1, 5, 5, 2, 3, 6) = 3";
is noble((1, 5, 2, 6, 7, 4)),          (), "(1, 5, 2, 6, 7, 4) = ()";
is noble((1, 2, 4, 5, 6, 7, 8, 9, 22)), 5, "(1, 2, 4, 5, 6, 7, 8, 9, 22) = 5";

sub noble(@L is copy) {
    @L = @L.sort;

    for @L.kv -> $k, $v {
        my @rest = @L[$k+1 .. @L.end];
        last if $v > @rest;
        return $v if @rest.grep(* > $v) == $v;
    }

    return ();
}
