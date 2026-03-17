#!/usr/bin/env perl

# Perl Weekly Challenge 307 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-307/

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
say "(", join(", ", compare_order(@ARGV)), ")";

sub compare_order {
    my(@nums) = @ARGV;
    my @ordered = sort {$a <=> $b} @nums;
    my @indices;
    for (0 .. $#nums) {
        push @indices, $_ if $nums[$_] != $ordered[$_];
    }
    return @indices;
}
