#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 193 Task 1 Binary String
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an integer, $n > 0.
# Write a script to find all possible binary numbers of size $n.
# Example 1 Input: $n = 2 Output: 00, 11, 01, 10
# Example 2 Input: $n = 3 Output: 000, 001, 010, 100, 111, 110, 101, 011
#
# Not sure what creates this order of numbers, will pass tests if the same
# set of numbers is generated.
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub _bs($n)
{
    my @s = ();
    for ( 0 .. 2**$n-1) 
    {
        push @s, sprintf("%0${n}b", $_);
    }
    return \@s;
}

sub binaryString($n)
{
    return join ", ", sort { $a cmp $b } _bs($n)->@*;
}

sub runTest
{
    use Test2::V0;

    is( _bs(2), bag { item $_ for qw/ 00 01 10 11 / }, "Example 1 bag");
    is( _bs(3), bag { item $_ for qw/ 000 001 010 011 100 101 110 111 / }, "Example 2 bag");

    is( binaryString(2), "00, 01, 10, 11", "Example 1");
    is( binaryString(3), "000, 001, 010, 011, 100, 101, 110, 111", "Example 2");

    done_testing;
}

