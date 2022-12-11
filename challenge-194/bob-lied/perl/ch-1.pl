#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Perl Weekly Challenge, Week 194, Task 1: Digital Clock
#=============================================================================
# Copyright (c) 2022, Bob Lied
#=============================================================================
# You are given time in the format hh:mm with one missing digit.
# Write a script to find the highest digit between 0-9 that makes it valid time.
# Example 1 Input: $time = '?5:00' Output: 1
#   Since 05:00 and 15:00 are valid time and no other digits can fit in the
#   missing place.
# Example 2 Input: $time = '?3:00' Output: 2
# Example 3 Input: $time = '1?:00' Output: 9
# Example 4 Input: $time = '2?:00' Output: 3
# Example 5 Input: $time = '12:?5' Output: 5
# Example 6 Input: $time = '12:5?' Output: 9
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say replaceDigit($_) for @ARGV;

sub replaceDigit($t)
{
    my $pos = index($t, "?");
    if ( $pos < 0 )
    {
        warn "$t does not contain '?'";
        return '?';
    }

    return 2 if ( $pos == 0 );
    return 5 if ( $pos == 3 );
    return 9 if ( $pos == 4 );

    if ( $pos == 1 ) { return ( substr($t, 0, 1) eq "1" ) ? 9 : 3; }

    warn "$t has '?' in strange place";
    return '?';
}

sub runTest
{
    use Test::More;

    is( replaceDigit("?3:00"), 2, "?3:00");
    is( replaceDigit("1?:00"), 9, "?3:00");
    is( replaceDigit("2?:00"), 3, "?3:00");
    is( replaceDigit("12:?5"), 5, "?3:00");
    is( replaceDigit("12:5?"), 9, "?3:00");

    done_testing;
}

