#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 179 Task 2 Unicode Sparkline
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of positive numbers, @n.
# Write a script to print sparkline in Unicode for the given list of numbers.
#
# This seems to be a very brief description of the challenge from RosettaCode
# https://rosettacode.org/wiki/Sparkline_in_unicode
# Use the following series of Unicode characters to create a program that
# takes a series of numbers separated by one or more whitespace or comma
# characters and generates a sparkline-type bar graph of the values on a
# single line of output.
# The eight characters: '▁▂▃▄▅▆▇█' (Unicode values U+2581 through U+2588).
# Use your program to show sparklines for the following input, here on this page:
# 1 2 3 4 5 6 7 8 7 6 5 4 3 2 1 ▁▂▃▄▅▆▇█▇▆▅▄▃▂▁
# 1.5, 0.5 3.5, 2.5 5.5, 4.5 7.5, 6.5 ▂▁▄▃▆▅█▇
# (note the mix of separators in this second case)!
# Notes
#   A space is not part of the generated sparkline.
#   The sparkline may be accompanied by simple statistics of the data such as
#   its range.
#   A suggestion emerging in later discussion (see Discussion page) is that
#   the bounds between bins should ideally be set to yield the following
#   results for two particular edge cases:
#   0, 1, 19, 20 -> ▁▁██ (Aiming to use just two spark levels)
#   0, 999, 4000, 4999, 7000, 7999 -> ▁▁▅▅██ (Aiming for three spark levels)
#=============================================================================

use v5.36;
binmode(STDOUT, ":encoding(UTF-8)");

use List::SomeUtils qw/minmax/;

my @Level = ( "\N{LOWER ONE EIGHTH BLOCK}",
              "\N{LOWER ONE QUARTER BLOCK}",
              "\N{LOWER THREE EIGHTHS BLOCK}",
              "\N{LOWER HALF BLOCK}",
              "\N{LOWER FIVE EIGHTHS BLOCK}",
              "\N{LOWER THREE QUARTERS BLOCK}",
              "\N{LOWER SEVEN EIGHTHS BLOCK}",
              "\N{FULL BLOCK}" );

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say sparkLine(\@ARGV);

sub sparkLine($list)
{
    my ($min, $max) = minmax $list->@*;
    my $range = $max - $min+1;

    my @bucket = map { int( ($_-$min) / ($range/@Level) ) } $list->@*;

    my @histogram = map { $Level[$_] } @bucket;

    return join("", @histogram);
}

sub runTest
{
    use Test2::V0;

    is( sparkLine([1,2,3,4,5,6,7,8,7,6,5,4,3,2,1]),   "▁▂▃▄▅▆▇█▇▆▅▄▃▂▁", "Example 1");
    is( sparkLine([1.5,0.5,3.5,2.5,5.5,4.5,7.5,6.5]), "▂▁▄▃▆▅█▇",        "Example 2");
    is( sparkLine([0,1,19,20]),                       "▁▁██",            "Two levels");
    is( sparkLine([0,999,4000,4999,7000,7999]),       "▁▁▅▅██",          "Three levels");

    done_testing;
}

