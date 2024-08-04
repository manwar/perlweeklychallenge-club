#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 280 Task 1 Twice Appearance
#=============================================================================
# You are given a string, $str, containing lowercase English letters only.
# Write a script to print the first letter that appears twice.
# Example 1 Input: $str = "acbddbca"
#           Output: "d"
# Example 2 Input: $str = "abccd"
#           Output: "c"
# Example 3 Input: $str = "abcdabbb"
#           Output: "a"
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say twice(lc $_) for @ARGV;

sub twice($str)
{
    my %present;
    for ( split(//, $str) )
    {
        return $_ if $present{$_}++;
    }
    return "";
}

sub twice2($str)
{
    my @present; # = (false) x 26;
    for ( split(//, $str) )
    {
        return $_ if $present[ord($_)]++;
    }
    return "";
}

sub twice3($str)
{
    my @present; # = (false) x 26;
    while ( my $c = substr($str, 0, 1, "") )
    {
        return $c if $present[ord($c)]++;
    }
    return "";
}


sub runTest
{
    use Test2::V0;

    is( twice("acbddbca"), "d", "Example 1");
    is( twice("abccd")   , "c", "Example 2");
    is( twice("abcdabbb"), "a", "Example 3");
    is( twice("abcdefgh"), "",  "No repeats");

    is( twice2("acbddbca"), "d", "t2 Example 1");
    is( twice2("abccd")   , "c", "t2 Example 2");
    is( twice2("abcdabbb"), "a", "t2 Example 3");
    is( twice2("abcdefgh"), "",  "t2 No repeats");

    is( twice3("acbddbca"), "d", "t3 Example 1");
    is( twice3("abccd")   , "c", "t3 Example 2");
    is( twice3("abcdabbb"), "a", "t3 Example 3");
    is( twice3("abcdefgh"), "",  "t3 No repeats");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;
    my $str = "abcdefghijklmnopqrstuvwxyzz";

    cmpthese($repeat, {
            withhash   => sub { twice($str) },
            witharray  => sub { twice2($str) },
            withsubstr => sub { twice3($str) },
        });
}
