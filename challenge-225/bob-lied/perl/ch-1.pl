#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Task 1 Max Words
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of sentences, @list.
# A sentence is a list of words that are separated by a single space with
# no leading or trailing spaces.
# Write a script to find out the maximum number of words that appear in a
# single sentence.
# Example 1 Input: @list = ("Perl and Raku belong to the same family.",
#                           "I love Perl.",
#                           "The Perl and Raku Conference.")
#          Output: 8
# Example 2 Input: @list = ("The Weekly Challenge.",
#                           "Python is the most popular guest language.",
#                           "Team PWC has over 300 members.")
#       Output: 7
#=============================================================================

use v5.36;

use List::Util qw/max/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say maxWords(\@ARGV);

sub maxWords($list)
{
    return List::Util::max map { scalar(split(" ", $_)) } @$list;
}

sub runTest
{
    use Test2::V0;

    is( maxWords(
[ "Perl and Raku belong to the same family.",
  "I love Perl.",
  "The Perl and Raku Conference." ]
            ), 8, "Example 1");

    is( maxWords(
[ "The Weekly Challenge.",
  "Python is the most popular guest language.",
  "Team PWC has over 300 members." ],
            ), 7, "Example 2");

    done_testing;
}

