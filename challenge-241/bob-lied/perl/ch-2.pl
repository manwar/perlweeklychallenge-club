#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 241 Task 2 Prime Order 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of unique positive integers greater than 2.
# Write a script to sort them in ascending order of the count of their
# prime factors, tie-breaking by ascending value.
# Example 1 Input: @int = (11, 8, 27, 4)
#           Output: (11, 4, 8, 27))
#   Prime factors of 11 => 11
#   Prime factors of  4 => 2, 2
#   Prime factors of  8 => 2, 2, 2
#   Prime factors of 27 => 3, 3, 3
#=============================================================================

use v5.38;

use Math::Prime::Util qw/factor/;
use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say "(", join(", ", primeOrder(@ARGV)->@*), ")";

sub primeOrder(@int)
{
    [
        map { $_->[0] }
            sort { $a->[1] <=> $b->[1] || $a->[0] <=> $b->[0] }
                map { [ $_, scalar(factor($_)) ] } @int
    ]
}

sub runTest
{
    use Test2::V0;

    is( primeOrder(11, 8, 27, 4), [ 11, 4, 8, 27 ], "Example 1");

    done_testing;
}
