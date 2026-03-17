#!/usr/bin/env perl

# Perl Weekly Challenge 272 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-272/

use Modern::Perl;

say score(shift // "");

sub score {
    my($str) = @_;
    my @chars = map {ord} split //, $str;
    my $score = 0;
    for (0 .. $#chars-1) {
        $score += abs($chars[$_+1] - $chars[$_]);
    }
    return $score;
}
