#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 299 Task 1 Replacw Words
#=============================================================================
# You are given an array of words and a sentence.  Write a script to
# replace # all words in the given sentence that start with any of the
# words in the given array.
# Example 1 Input: @words = ("cat", "bat", "rat")
#                  $sentence = "the cattle was rattle by the battery"
#           Output: "the cat was rat by the bat"
# Example 2 Input: @words = ("a", "b", "c")
#                  $sentence = "aab aac and cac bab"
#           Output: "a a a c b"
# Example 3 Input: @words = ("man", "bike")
#                  $sentence = "the manager was hit by a biker"
#           Output: "the man was hit by a bike"
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say replace(@ARGV);

sub replace($sentence, @words)
{
    my $pat = join("|", @words);
    return join(" ", map { s/^($pat).*/$1/r } split(" ", $sentence) );
}

sub runTest
{
    use Test2::V0;

    is( replace("the cattle was rattle by the battery",
                qw(cat bat rat)), "the cat was rat by the bat", "Example 1");
    is( replace("aab aac and cac bab",
                qw(a b c)),       "a a a c b",                  "Example 2");
    is( replace("the manager was hit by a biker",
                qw(man bike)),    "the man was hit by a bike",  "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
