#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Task 2 Count Words 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of words made up of alphabetic characters and a
# prefix. Write a script to return the count of words that starts with the
# given prefix.
# Example 1 Input: @words  = ("pay", "attention", "practice", "attend")
#                  $prefix = "at"
#          Output: 2
#   Two words "attention" and "attend" starts with the given prefix "at".
# Example 2 Input: @words  = ("janet", "julia", "java", "javascript")
#                  $prefix = "ja"
#           Ouput: 3
# Three words "janet", "java" and "javascript" starts with the prefix "ja".
#=============================================================================

use v5.36;

use FindBin qw($Bin);
use lib "$FindBin::Bin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;
my $Prefix  = "";

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "prefix:s" => \$Prefix);
exit(!runTest()) if $DoTest;

say countWords($Prefix, @ARGV);

sub countWords($prefix, @wordList)
{
    my $plen = length($prefix);
    my $count = grep { substr($_, 0, $plen) eq $prefix } @wordList;
    return $count;
}

sub runTest
{
    use Test2::V0;

    is( countWords("at", qw(pay attention practice attend) ), 2, "Example 1");
    is( countWords("ja", qw(janet julia java javascript)   ), 3, "Example 2");

    done_testing;
}
