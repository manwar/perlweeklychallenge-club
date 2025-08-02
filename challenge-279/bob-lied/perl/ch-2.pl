#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 279 Task 2 Split String
#=============================================================================
# You are given a string, $str.
# Write a script to split the given string into two containing exactly
# same number of vowels and return true if you can otherwise false.
# Example 1 Input: $str = "perl"
#           Ouput: false
# Example 2 Input: $str = "book"
#           Ouput: true
#   Two possible strings "bo" and "ok" containing exactly one vowel each.
# Example 3 Input: $str = "good morning"
#           Ouput: true
#   Two possible strings "good " and "morning" containing two vowels each
#   or "good m" and "orning" containing two vowels each. (Others also work).
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say splitString($_) for @ARGV;

sub splitString($str)
{
    # Too easy. It's possible if there's an even number of vowels.
    return ($str =~ tr/aeiou//d) % 2 == 0;
}

sub runTest
{
    use Test2::V0;

    is( splitString("perl"),         false, "Example 1");
    is( splitString("book"),         true,  "Example 2");
    is( splitString("good morning"), true,  "Example 3");
    is( splitString("xyzzy"),  true,  "No vowels");
    is( splitString("aeiou"),  false, "All vowels, odd");
    is( splitString("aeioua"), true,  "All vowels, even");


    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

