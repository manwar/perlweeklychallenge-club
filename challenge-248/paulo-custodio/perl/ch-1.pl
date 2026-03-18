#!/usr/bin/env perl

# Perl Weekly Challenge 248 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-248/

use Modern::Perl;
use List::Util 'min';

my @dists = calc_dists(@ARGV);
say "(", join(", ", @dists), ")";

sub calc_dists {
    my($str, $char) = @_;
    my @str = split //, $str;
    my @dist = ((1e10) x @str);
    for my $i (0 .. $#str) {
        if ($str[$i] eq $char) {
            $dist[$i] = 0;
            for my $j (1 .. $i) {
                $dist[$i-$j] = min($dist[$i-$j], $j);
            }
            for my $j (1 .. $#str-$i) {
                $dist[$i+$j] = min($dist[$i+$j], $j);
            }
        }
    }
    return @dist;
}
