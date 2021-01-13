#!/usr/bin/env raku

sub MAIN (UInt $N where $N > 1) {
    my @ans = gather {
        for 2..$N.sqrt -> $base {
            my $log = log($N, $base);
            take "$base^" ~ $log.floor if $log.Rat.denominator == 1;
        }
    }

    .say for @ans or 0;
}
