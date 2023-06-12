#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 220 Task 1 Common Characters 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of words.
# Write a script to return the list of common characters (sorted
# alphabetically) found in every word of the given list.
# Example 1 Input: @words = ("Perl", "Rust", "Raku")
#           Output: ("r")
# Example 2 Input: @words = ("love", "live", "leave")
#           Output: ("e", "l", "v")
#=============================================================================

use v5.36;

use List::Util qw(all uniq);

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub commonCharacters($list)
{
    my @lcList = map { lc } @$list;
    my $firstWord = shift @lcList;
    my @possible = uniq sort split //, $firstWord;

    sub isEverywhere($c, $words) { all {index($_, $c) >= 0  } @$words };

    my @common = grep { isEverywhere($_, \@lcList) } @possible;

    return \@common;
}

sub runTest
{
    use Test2::V0;

    is(commonCharacters( [ qw(Perl Rust Raku) ] ), [ qw(r) ], "Example 1");
    is(commonCharacters( [ qw(love live leave)] ), [ qw(e l v) ], "Example 1");

    done_testing;
}
