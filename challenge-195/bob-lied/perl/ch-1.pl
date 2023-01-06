#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 195, Task 1 Special Integers
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a positive integer, $n > 0.
# Write a script to print the count of all special integers between 1 and $n.
# An integer is special when all of its digits are unique.
# Example 1: Input: $n = 15 Output: 14 
#       because except 11 all other integers between 1 and 15 are spcial.
# Example 2: Input: $n = 35 Output: 32
#       because except 11, 22, 33 all others are special.
# 
#=============================================================================

use v5.36;

use Scalar::Util::Numeric qw/isint/;
use List::Util qw/any sum/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say ( isint($_) && countSpecial($_) ) for @ARGV;

sub isSpecial($n)
{
    my @digitCount = (0) x 10;
    $digitCount[$_]++ for split('', $n);
    # We want a 0, not undef or '' for false
    return ( List::Util::any { $_ > 1 } @digitCount ) ? 0 : 1;
}

sub countSpecial($n)
{
    return List::Util::sum map { isSpecial($_) } 1..$n;
}

sub runTest
{
    use Test2::V0;

    is( isSpecial( 0), 1, "isSpecial 0");
    is( isSpecial( 1), 1, "isSpecial 1");
    is( isSpecial( 9), 1, "isSpecial 9");
    is( isSpecial(22), 0, "isSpecial 22");
    is( isSpecial(12), 1, "isSpecial 12");
    is( isSpecial(1234567890), 1, "isSpecial 1-0");
    is( isSpecial(9878675675), 0, "isSpecial lots");

    is( countSpecial(15), 14, "Example 1");
    is( countSpecial(35), 32, "Example 2");

    done_testing;
}

