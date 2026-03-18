#!/usr/bin/env perl

# Perl Weekly Challenge 276 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-276/

use Modern::Perl;
use List::Util 'max';

say max_freq(@ARGV);

sub max_freq {
    my(@ints) = @_;
    my %count; $count{$_}++ for @ints;
    my $max_count = max(values %count);
    my $max_freq = scalar grep {$count{$_} == $max_count} keys %count;
    return $max_freq;
}
