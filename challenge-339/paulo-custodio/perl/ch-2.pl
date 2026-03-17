#!/usr/bin/env perl

# Perl Weekly Challenge 339 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-339/

use Modern::Perl;
use List::Util qw(max);

@ARGV or die "usage: $0 nums..\n";
say peek_point(@ARGV);

sub peek_point {
    my(@nums) = @_;
    my $peek = 0;
    my $pos = 0;
    for (@nums) {
        $pos += $_;
        $peek = max($peek, $pos);
    }
    return $peek;
}
