#!/usr/bin/env perl

# Perl Weekly Challenge 269 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-269/

use Modern::Perl;

say trailing_zero(@ARGV) ? 'true' : 'false';

sub trailing_zero {
    my(@ints) = @_;
    my $count_trailing_zero = grep {($_ & 1) == 0} @ints;
    return $count_trailing_zero >= 2;
}
