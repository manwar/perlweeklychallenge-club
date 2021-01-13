#!/usr/bin/env perl6

use v6.c;

sub MAIN(Int $n is copy where $n > 0) {
    my @collatz = ($n);
    while $n != 1 {
        $n = collatz-sequence($n);
        push @collatz, $n;
    }
    say @collatz.join(" -> ");
}

multi sub collatz-sequence(Int $n where $n  %% 2) { $n div 2   }

multi sub collatz-sequence(Int $n where $n !%% 2) { 3 * $n + 1 }
