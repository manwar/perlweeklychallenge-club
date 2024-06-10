#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 273 Task 1 Percentage of Character
#=============================================================================
# You are given a string, $str and a character $char.
# Write a script to return the percentage, nearest whole, of given
# character in the given string.
# Example 1 Input: $str = "perl", $char = "e"
#           Output: 25
# Example 2 Input: $str = "java", $char = "a"
#           Output: 50
# Example 3 Input: $str = "python", $char = "m"
#           Output: 0
# Example 4 Input: $str = "ada", $char = "a"
#           Output: 67
# Example 5 Input: $str = "ballerina", $char = "l"
#           Output: 22
# Example 6 Input: $str = "analitik", $char = "k"
#           Output: 13
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say pctOfChar(@ARGV);

sub pctOfChar($str, $char)
{
    # Solutioh 1: delete everything that isn't char, use remaining length
    # my $occur = length( $str =~ s/[^$char]//gr );
    
    # Solution 2: Global match in list context yields an array of
    # matching characters. Assigning to scalar yields length of the list.
    my $occur = @{[ $str =~ m/$char/g ]};
    return int( 100*($occur / length($str)) + 0.5 );
}

sub runTest
{
    use Test2::V0;

    is( pctOfChar("perl",      "e"), 25, "Example 1 perl e");
    is( pctOfChar("java",      "a"), 50, "Example 2 java a");
    is( pctOfChar("python",    "m"),  0, "Example 3 python m");
    is( pctOfChar("ada",       "a"), 67, "Example 4 ada a");
    is( pctOfChar("ballerina", "l"), 22, "Example 5 ballerina l");
    is( pctOfChar("analitik",  "k"), 13, "Example 6 analitik k");

    is( pctOfChar("rrrr", "r"), 100, "100%");

    done_testing;
}
