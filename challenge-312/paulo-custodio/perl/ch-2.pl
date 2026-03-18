#!/usr/bin/env perl

# Perl Weekly Challenge 312 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-312/

use Modern::Perl;

say box_with_3_colors(shift // "");

sub box_with_3_colors {
    my($spec) = @_;
    my %boxes;
    while ($spec =~ /([RGB])(\d)/g) {
        $boxes{$2}{$1}++;
    }

    my $count = 0;
    for my $box (keys %boxes) {
        if ($boxes{$box}{R} && $boxes{$box}{G} && $boxes{$box}{B}) {
            $count++;
        }
    }
    return $count;
}
