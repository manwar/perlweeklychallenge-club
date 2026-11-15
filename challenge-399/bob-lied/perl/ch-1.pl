#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 399 Task 1  Longest Repeating Character
#=============================================================================
# You are given a string str and an integer k > 0.  Write a script to choose
# any character of str and change it to another character. You may perform
# this operation up to k times. Return the length of the longest reachable
# substring of a single letter.
# Example 1 Input: $str = "AAAAA", $k = 2
#           Output: 5
#   Every character in the string is already the same letter "A".
#   The maximum operations allowed (k = 2) do not even need to be used.
#   The entire string of length 5 is already the longest valid substring.
#
# Example 2 Input: $str = "ABCDE", $k = 4
#           Output: 5
#   All 5 characters in the string are distinct.  The most frequent character
#   occurs only 1 time.  To turn the entire string into a single repeated
#   character, we need to replace 5 - 1 = 4 characters.  Since k = 4, we can
#   replace "B","C","D", and "E" with "A" to form "AAAAA".
#
# Example 3 Input: $str = "AAABBBBAA", $k = 1
#           Output: 5
#   If we target "A", we could change the "B" in "AAAB" (k=1 replacement)
#   to get length 4 ("AAAA").  If we target "B", we can pick the substring
#   "BBBBA" and change the single trailing "A" to "B" (k=1 replacement) to
#   form "BBBBB", which gives a length of 5.  Targeting "B" gives better
#   result than targeting "A".
#
# Example 4 Input: $str = "ABACADA", $k = 2
#           Output: 5
#   Look at the substring [0..4] which is "ABACA" (length 5).  In this window,
#   "A" appears 3 times, and there are 2 non-"A" characters ("B" and "C").
#   With k = 2, we can replace "B" and "C" with "A" to form "AAAAA".
#   Look at the substring [2..6] which is "ACADA" (length 5).  Here, "A"
#   appears 3 times, and non-"A" characters ("C" and "D") count to 2.
#   Replacing them gives "AAAAA".  In both cases, the maximum valid length is 5.
#
# Example 5 Input: $str = "BAAABAAAA", $k = 1
#           Output: 8
#   The string has two groups of "A"s separated by a single "B" ("AAABAAAA").
#   We can replace the character 4 "B" with an "A" to get a sequence of 8 "A".
#=============================================================================

use v5.44;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

my $K = 1;

GetOptions("k:i" => \$K,
           "test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say task($_, $K) for @ARGV;

#=============================================================================
sub task($str, $k)
{
    my $longest = 1;
    my $strlen;
    while ( ($strlen = length($str)) > 0 && $strlen > $longest )
    {
        # Shift left-most character off str
        my $c = substr($str, 0, 1, "");

        # Make as many substitutions as possible
        my $copy = $str;
        $copy =~ s/[^$c]/$c/ for 1 .. $k;

        # Check the length of repeated first character
        $copy =~ m/^($c+)/;
        my $run = 1 + length($1 // "");

        $longest = $run if $run > $longest;
    }
    return $longest;
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task(    "AAAAA", 2), 5, "Example 1"); 
    is( task(    "ABCDE", 4), 5, "Example 2");
    is( task("AAABBBBAA", 1), 5, "Example 3");
    is( task(  "ABACADA", 2), 5, "Example 4");
    is( task("BAAABAAAA", 1), 8, "Example 5");

    is( task("A", 9), 1, "Length=1");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
