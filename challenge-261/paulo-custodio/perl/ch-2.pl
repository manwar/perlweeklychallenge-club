#!/usr/bin/env perl

# Perl Weekly Challenge 261 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-261/

use Modern::Perl;

my($start, @ints) = @ARGV;
say mult_two($start, @ints);

sub mult_two {
    my($n, @ints) = @_;
    while (grep {$_ == $n} @ints) {
        $n *= 2;
    }
    return $n;
}
