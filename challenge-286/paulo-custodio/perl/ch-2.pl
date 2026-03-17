#!/usr/bin/env perl

# Perl Weekly Challenge 286 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-286/

use Modern::Perl;
use List::Util qw( min max );

my @nums = @ARGV;
@nums = reduce(@nums) while @nums > 1;
say $nums[0];

sub reduce {
    my(@nums) = @_;
    my @out;
    while (@nums) {
        if (@nums >= 2) {
            push @out, min(@nums[0..1]);
        }
        if (@nums >= 4) {
            push @out, max(@nums[2..3]);
        }
        splice(@nums, 0, 4);
    }
    return @out;
}
