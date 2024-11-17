#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 295 Task 1 Word Break
#=============================================================================
# You are given a string, $str, and list of words, @words.
# Write a script to return true or false whether the given string can be
# segmented into a space separated sequnce of one or more words from the
# given list.
# Example 1 Input: $str = 'weeklychallenge', @words = ("challenge", "weekly")
#           Output: true
# Example 2 Input: $str = "perlrakuperl", @words = ("raku", "perl")
#           Output: true
# Example 3 Input: $str = "sonsanddaughters", @words = ("sons", "sand", "daughters")
#           Output: false
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

my $str = shift;
say wordBreak($str, @ARGV) ? "true" : "false";

sub wordBreak($str, @words)
{
    my $re = '^(' . join('|', @words) . ')+$';
    return scalar $str =~ m/$re/;
}

sub runTest
{
    use Test2::V0;

    is( wordBreak('weeklychallenge',  qw(challenge weekly)),     true, "Example 1");
    is( wordBreak('perlrakuperl',     qw(raku perl)),            true, "Example 2");
    is( wordBreak('sonsanddaughters', qw(sons sand daughters)), false, "Example 3");

    is( wordBreak('perdogson',        qw(dog person)),          false, "Dog first");
    is( wordBreak('perdogson',        qw(person dog)),          false, "Person first");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
