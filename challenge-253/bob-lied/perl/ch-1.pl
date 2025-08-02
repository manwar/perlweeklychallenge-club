#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 253 Task 1 Split Strings
#=============================================================================
# You are given an array of strings and a character separator.
# Write a script to return all words separated by the given character
# excluding empty string.
# Example 1 Input: @words = ("one.two.three","four.five","six") $separator = "."
#           Output: "one","two","three","four","five","six"
# Example 2 Input: @words = ("$perl$$", "$$raku$") $separator = "$"
#           Output: "perl","raku"
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;
my $Separator = " ";

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "sep:s" => \$Separator);
exit(!runTest()) if $DoTest;

say join ",", map { qq("$_") } splitStrings(\@ARGV, $Separator)->@*;

sub splitStrings($words, $separator)
{
    my @output = grep !/\A\Z/, map { split /\Q$separator\E+/, $_ } $words->@*;
    return \@output;
}

sub runTest
{
    use Test2::V0;

    is( splitStrings( ["one.two.three", "four.five", "six" ], "." ),
                      [ qw(one two three four five six) ], "Example 1");
    is( splitStrings( [ '$perl$$', '$$raku$' ], '$' ),
                      [ qw( perl raku ) ], "Example 1");

    is( splitStrings( [ qw(a b c) ],         '/' ),  [ qw(a b c) ], "No separator");
    is( splitStrings( [ "////", "//", "/", ], "/" ), [ ],           "No words");

    done_testing;
}
