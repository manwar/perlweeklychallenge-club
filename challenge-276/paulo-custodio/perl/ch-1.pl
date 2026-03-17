#!/usr/bin/env perl

# Perl Weekly Challenge 276 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-276/

use Modern::Perl;

say complete_days(@ARGV);

sub complete_days {
    my(@hours) = @_;
    my $pairs = 0;
    for my $i (0 .. $#hours-1) {
        for my $j ($i+1 .. $#hours) {
            $pairs++ if ($hours[$i]+$hours[$j]) % 24 == 0;
        }
    }
    return $pairs;
}
