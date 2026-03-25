#!/usr/bin/env perl

# Perl Weekly Challenge 211 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-211/

use Modern::Perl;
use List::Util 'sum';

sub split_same_avg_ {
    my($found, $a, $b, @pending) = @_;
    if ($$found) {
    }
    elsif (!@pending) {
        my @a = @$a;
        my @b = @$b;
        if (@a && @b && abs(sum(@a)/@a - sum(@b)/@b) < 1e-6) {
            $$found = 1;
        }
    }
    else {
        split_same_avg_($found, [@$a, $pending[0]], $b, @pending[1..$#pending]);
        split_same_avg_($found, $a, [@$b, $pending[0]], @pending[1..$#pending]);
    }
}

sub split_same_avg {
    my(@nums) = @_;
    my $found = 0;
    split_same_avg_(\$found, [], [], @nums);
    return $found;
}

@ARGV or die "usage: ch-2.pl nums...\n";
say split_same_avg(@ARGV);
