#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 239 Task 1 Same String 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given two arrays of strings.
# Write a script to find out if the word created by concatenating the array
# elements is the same.
# Example 1 Input: @arr1 = ("ab", "c") @arr2 = ("a", "bc")
#           Output: true
#   Using @arr1, word1 => "ab" . "c" => "abc"
#   Using @arr2, word2 => "a" . "bc" => "abc"
# Example 2 Input: @arr1 = ("ab", "c") @arr2 = ("ac", "b")
#          Output: false
# Example 3 Input: @arr1 = ("ab", "cd", "e") @arr2 = ("abcde")
#          Output: true
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my $arr1 = shift;
my $arr2 = shift;

die qq(Usage $0 "list 1" "list 2") unless $arr1 and $arr2;

say STDOUT ( sameString([ split(' ', $arr1) ], [ split(' ', $arr2) ] ) )
      ? "true"
      : "false"
      ;

sub sameString($listA, $listB)
{
    local $" = '';
    return "$listA->@*" eq "$listB->@*";
}

sub ss2($listA, $listB)
{
    return join("", $listA->@*) eq join("", $listB->@*);
}

sub runTest
{
    use Test2::V0;
    no warnings "experimental::builtin";

    is( sameString(["ab", "c"], ["a", "bc"]),     true,  "Example 1");
    is( sameString(["ab", "c"], ["ac", "b"]),     false, "Example 2");
    is( sameString(["ab", "cd", "e"], ["abcde"]), true,  "Example 3");

    done_testing;
}
