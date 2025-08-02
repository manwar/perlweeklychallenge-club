#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 278 Task 1 Sort String
#=============================================================================
# You are given a shuffle string, $str.
# Write a script to return the sorted string.
# A string is shuffled by appending word position to each word.
# Example 1 Input: $str = "and2 Raku3 cousins5 Perl1 are4"
#           Output: "Perl and Raku are cousins"
# Example 2 Input: $str = "guest6 Python1 most4 the3 popular5 is2 language7"
#           Output: "Python is the most popular guest language"
# Example 3 Input: $str = "Challenge3 The1 Weekly2"
#           Output: "The Weekly Challenge"
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say sortString($_) for @ARGV;

sub sortString($str)
{
    my @sentence;
    for ( split(' ', $str) )
    {
        my ($word, $place) = m/(\D*)(\d+)/;
        say "$_: [$place]=$word" if $Verbose;
        $sentence[$place // 0] = $word;
    }
    shift @sentence; # 0 not expected to be used
    return join(" ", @sentence);
}

sub runTest
{
    use Test2::V0;

    is( sortString("and2 Raku3 cousins5 Perl1 are4"),
                   "Perl and Raku are cousins", "Example 1");
    is( sortString("guest6 Python1 most4 the3 popular5 is2 language7"),
                   "Python is the most popular guest language", "Example 2");
    is( sortString("Challenge3 The1 Weekly2"),
                   "The Weekly Challenge", "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

