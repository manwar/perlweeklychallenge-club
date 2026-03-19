#!/usr/bin/env perl

# Perl Weekly Challenge 226 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-226/

use Modern::Perl;
use List::Util 'min';

say num_ops(@ARGV);

sub num_ops {
    my(@n) = @_;
    my $ops = 0;
    while (grep {$_ > 0} @n) {
        my $min = min(grep {$_ > 0} @n);
        @n = map {$_ > 0 ? $_-$min : 0} @n;
        $ops++;
    }
    return $ops;
}
