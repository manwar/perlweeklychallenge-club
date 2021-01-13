#!/usr/bin/env raku

#
# Perl Weekly Challenge - 069
#
# Task #1: Strobogrammatic Number
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-069
#

use Test;

is-deeply strobogrammatic-numbers(50, 100),
          (69, 88, 96),
          'testing $A=50, $B=100';

done-testing;

sub strobogrammatic-numbers($start, $stop) {
    die "ERROR: Invalid start number [$start].\n"
        unless $start < $stop;

    my %digits = (6 => 9, 8 => 8, 9 => 6);

    my @strobogrammatic = ();
    for $start .. $stop -> $n {
        next if $n < 10;

        my $found = True;
        my @match = ();
        for $n.comb -> $i {
            if %digits{$i}:exists {
                @match.push: %digits{$i};
            }
            else {
                $found = False;
                last;
            }
        }

        if $found {
            @strobogrammatic.push: $n
                if $n == @match.join('').flip;
        }
    }

    return |@strobogrammatic;
}
