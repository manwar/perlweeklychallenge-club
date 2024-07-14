#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 277 Task 1 Count Common
#=============================================================================
# You are given two array of strings, @words1 and @words2.
# Write a script to return the count of words that appears in both
# arrays exactly once.
# Example 1 Input: @words1 = ("Perl", "is", "my", "friend")
#                  @words2 = ("Perl", "and", "Raku", "are", "friend")
#       Output: 2
#   The words "Perl" and "friend" appear once in each array.
# Example 2 Input: @words1 = ("Perl", "and", "Python", "are", "very", "similar")
#                  @words2 = ("Python", "is", "top", "in", "guest", "languages")
#       Output: 1
# Example 3 Input: @words1 = ("Perl", "is", "imperative", "Lisp", "is", "functional")
#                  @words2 = ("Crystal", "is", "similar", "to", "Ruby")
#       Output: 0
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

my @words1 = split('', shift @ARGV);
my @words2 = split('', shift @ARGV);

say countCommon(\@words1, \@words2);

sub countCommon($words1, $words2)
{
    use List::MoreUtils qw/frequency/;
    my %common = frequency $words1->@*;

    for ( keys %common ) { delete $common{$_} if $common{$_} != 1 }

    for ( $words2->@* ) { $common{$_}++ if exists $common{$_} }

    return scalar( grep { $_ == 2 } values %common);
}

sub runTest
{
    use Test2::V0;

    is( countCommon([ qw(Perl is my friend) ],
                    [ qw(Perl and Raku are friend) ]),         2, "Example 1");
    is( countCommon([ qw(Perl and Python are very similar) ],
                    [ qw(Python is top in guest languages) ]), 1, "Example 2");
    is( countCommon([ qw(Perl is imperative Lisp is functional) ],
                    [ qw(Crystal is similar to Ruby) ]),       0, "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

