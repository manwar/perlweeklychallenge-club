#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 189 Task 1 Greater Character
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of characters (a..z) and a target character.
# Write a script to find out the smallest character in the given array
# lexicographically greater than the target character.
# Example 1 Input: @array = qw/e m u g/, $target = 'b' Output: e
# Example 2 Input: @array = qw/d c e f/, $target = 'a' Output: c
# Example 3 Input: @array = qw/j a r/,   $target = 'o' Output: r
# Example 4 Input: @array = qw/d c a f/, $target = 'a' Output: c
# Example 5 Input: @array = qw/t g a l/, $target = 'v' Output: v
#=============================================================================

use v5.36;

use List::Util qw/min/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub usage() { "$0 a b c ... target" }

my @array = @ARGV;
my $target = pop @array;

say greaterCharacter(\@array, $target);

sub greaterCharacter($array, $target)
{
    # map -- make a list of differences from target
    # grep -- select only those that are greater
    # min -- take the smallest difference
    my $d = min grep { $_ > 0 } map { ord($_) - ord($target) } $array->@*;

    # If target is the greatest, return it, otherwise convert the
    # difference back to a character
    return ($d ? chr( ord($target) + $d) : $target);
}

sub runTest
{
    use Test2::V0;

    is( greaterCharacter( [ qw/e m u g/ ], 'b'), 'e', "Example 1");
    is( greaterCharacter( [ qw/d c e f/ ], 'a'), 'c', "Example 2");
    is( greaterCharacter( [ qw/j a r  / ], 'o'), 'r', "Example 3");
    is( greaterCharacter( [ qw/d c a f/ ], 'a'), 'c', "Example 4");
    is( greaterCharacter( [ qw/t g a l/ ], 'v'), 'v', "Example 5");

    done_testing;
}
