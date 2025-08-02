#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 275 Task 1 Broken Keys
#=============================================================================
# You are given a sentence, $sentence and list of broken keys @keys.
# Write a script to find out how many words can be typed fully.
# Example 1 Input: $sentence = "Perl Weekly Challenge", @keys = ('l', 'a')
#           Output: 0
#   Every word requires one of the broken keys.
# Example 2 Input: $sentence = "Perl and Raku", @keys = ('a')
#           Output: 1
#   Only Perl since the other word two words contain 'a' and can't be typed.
# Example 3 Input: $sentence = "Well done Team PWC", @keys = ('l', 'o')
#           Output: 2
# Example 4 Input: $sentence = "The joys of polyglottism", @keys = ('T')
#           Output: 2
#=============================================================================

use v5.40;

use Getopt::Long;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say brokenKeys(@ARGV);

sub brokenKeys($sentence, @keys)
{
    my @s = split(/\W+/, $sentence);
    for my $broken ( @keys )
    {
        @s = grep !/$broken/i, @s;
    }
    return scalar(@s);
}

sub bk($sentence, @keys)
{
    # my $re = '^[^' . join("", @keys) . ']*$';
    # return scalar grep /$re/i, split(/\W+/, $sentence);
    # my $re = '[' . join("", @keys) . ']';
    my $re;
    { local $, = ''; $re = qq([@keys]); }
    my @s = split(/\W+/, $sentence);
    return scalar(@s) - ( grep /$re/i, @s );
}

sub runTest
{
    use Test2::V0;

    is( brokenKeys("Perl Weekly Challenge",    'l', 'a'), 0, "Example 1");
    is( brokenKeys("Perl and Raku",            'a'     ), 1, "Example 2");
    is( brokenKeys("Well done Team PWC",       'l', 'o'), 2, "Example 3");
    is( brokenKeys("The joys of polyglottism", 'T'     ), 2, "Example 4");

    is( bk("Perl Weekly Challenge",    'l', 'a'), 0, "Example 1 bk");
    is( bk("Perl and Raku",            'a'     ), 1, "Example 2 bk");
    is( bk("Well done Team PWC",       'l', 'o'), 2, "Example 3 bk");
    is( bk("The joys of polyglottism", 'T'     ), 2, "Example 4 bk");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;
    my $sentence = "It's eighty degrees and I'm down on my knees in Brooklyn";

    cmpthese($repeat, {
            re   => sub { bk($sentence, qw(f a w z y) ) },
            loop => sub { brokenKeys($sentence, qw(f a w z y) ) },
        });
}
