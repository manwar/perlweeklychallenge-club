#!/usr/bin/env perl

# Perl Weekly Challenge 302 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-302/

use Modern::Perl;
use List::Util qw(min max);

@ARGV or die "usage: $0 nums...\n";

say min_start_value(@ARGV);

sub min_start_value {
    my(@steps) = @_;
    my $cur = 0;
    my @heights;
    for (@steps) {
        $cur += $_;
        push @heights, $cur;
    }
    my $min_height = min(@heights);
    return max(1, 1 - $min_height);
}
