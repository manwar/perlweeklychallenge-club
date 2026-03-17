#!/usr/bin/env perl

# Perl Weekly Challenge 269 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-269/

use Modern::Perl;

say "(", join(", ", distribute(@ARGV)), ")";

sub distribute {
    my(@ints) = @_;
    return @ints if @ints < 2;
    my @a1 = (shift @ints);
    my @a2 = (shift @ints);
    while (@ints) {
        if ($a1[-1] > $a2[-1]) {
            push @a1, shift @ints;
        }
        else {
            push @a2, shift @ints;
        }
    }
    return (@a1, @a2);
}
