#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 280 Task 2 Count Asterisks
#=============================================================================
# You are given a string, $str, where every two consecutive vertical bars
# are grouped into a pair.
# Write a script to return the number of asterisks, *, excluding any
# between each pair of vertical bars.
# Example 1 Input: $str = "p|*e*rl|w**e|*ekly|"
#           Ouput: 2
#   The characters we are looking here are "p" and "w**e".
# Example 2 Input: $str = "perl"
#           Ouput: 0
# Example 3 Input: $str = "th|ewe|e**|k|l***ych|alleng|e"
#           Ouput: 5
#   The characters we are looking here are "th", "e**", "l***ych" and "e".
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say count2($_) for @ARGV;

sub count($str)
{
    my @t = split(/\|/, $str);
    my $first = join "", @t[ map { $_ * 2 } 0 .. int($#t/2) ];
    return $first =~ tr/*//d;
}


sub count2($str)
{
    my @t = split(/\|/, $str);
    my $n = 0;
    while ( defined(my $s = shift @t) )
    {
        $n += $s =~ tr/*//d;
        shift @t;
    }
    return $n;
}

sub runTest
{
    use Test2::V0;

    is( count("p|*e*rl|w**e|*ekly|"), 2, "Example 1");
    is( count("perl"), 0, "Example 2");
    is( count("th|ewe|e**|k|l***ych|alleng|e"), 5, "Example 3");

    is( count2("p|*e*rl|w**e|*ekly|"), 2, "Example 1");
    is( count2("perl"), 0, "Example 2");
    is( count2("th|ewe|e**|k|l***ych|alleng|e"), 5, "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
