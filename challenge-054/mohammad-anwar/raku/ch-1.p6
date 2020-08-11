#!/usr/bin/env perl6

use v6.c;

sub MAIN(Int $n where * > 0, Int $k where * > 0) {
    die "ERROR: Invalid sequence number $k." unless $k <= [*] 1..$n;
    say ( 1..$n ).permutations.map({ .join })[$k -1];
}
