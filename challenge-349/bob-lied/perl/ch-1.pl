#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 349 Task 1  Power String
#=============================================================================
# You are given a string. Write a script to return the power of the given
# string. The power of the string is the maximum length of a non-empty
# substring that contains only one unique character.
# Example 1 Input: $str = "textbook"
#           Output: 2
#   Breakdown: "t", "e", "x", "b", "oo", "k"
#   The longest substring with one unique character is "oo".
# Example 2 Input: $str = "aaaaa"
#           Output: 5
# Example 3 Input: $str = "hoorayyy"
#           Output: 3
#   Breakdown: "h", "oo", "r", "a", "yyy"
#   The longest substring with one unique character is "yyy".
# Example 4 Input: $str = "x"
#           Output: 1
# Example 5 Input: $str = "aabcccddeeffffghijjk"
#           Output: 4
#   Breakdown: "aa", "b", "ccc", "dd", "ee", "ffff", "g", "h", "i", "jj", "k"
#   The longest substring with one unique character is "ffff".
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

say power($_) for @ARGV;

#=============================================================================
sub power($str)
{
    use List::Util qw/max/;
    return max map { length($_) } ($str =~ m/((.)\2*)/g);
}

sub runTest
{
    use Test2::V0;

    is( power(            "textbook"), 2, "Example 1");
    is( power(               "aaaaa"), 5, "Example 2");
    is( power(            "hoorayyy"), 3, "Example 3");
    is( power(                   "x"), 1, "Example 4");
    is( power("aabcccddeeffffghijjk"), 4, "Example 5");

    done_testing;
}
