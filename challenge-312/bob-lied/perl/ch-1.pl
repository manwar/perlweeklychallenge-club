#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 312 Task 1 Minimum Time
#=============================================================================
# You are given a typewriter with lowercase english letters a to z arranged
# in a circle. Typing a character takes 1 sec. You can move pointer one
# character clockwise or anti-clockwise. The pointer initially points at a.
# Write a script to return minimum time it takes to print the given string.
#
# Example 1 Input: $str = "abc"
#           Output: 5
#   The pointer is at 'a' initially.
#   1 sec - type the letter 'a'
#   1 sec - move pointer clockwise to 'b'
#   1 sec - type the letter 'b'
#   1 sec - move pointer clockwise to 'c'
#   1 sec - type the letter 'c'
#
# Example 2 Input: $str = "bza"
#           Output: 7
#   The pointer is at 'a' initially.
#   1 sec - move pointer clockwise to 'b'
#   1 sec - type the letter 'b'
#   1 sec - move pointer anti-clockwise to 'a'
#   1 sec - move pointer anti-clockwise to 'z'
#   1 sec - type the letter 'z'
#   1 sec - move pointer clockwise to 'a'
#   1 sec - type the letter 'a'
#
# Example 3 Input: $str = "zjpc"
#           Output: 34
#=============================================================================

use v5.40;
use List::Util qw/min sum0/;
use List::MoreUtils qw/slide/;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
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

say minTime($_) for @ARGV;

#=============================================================================
sub minTime($str)
{
    # List of pointer positions, beginning at A
    my @ptr = (0, map { ord($_) - ord("a") } split(//, $str));

    # Array of closest differences between positions
    my @d = slide { min(($a - $b) % 26, ($b-$a) % 26 ) } @ptr;

    # One second for each character in str, plus time to move
    my $t = length($str) + sum0(@d);
    return $t;
}

sub runTest
{
    use Test2::V0;

    is( minTime("a"), 1, "Single A");
    is( minTime("b"), 2, "Single B");
    is( minTime("m"), 13, "Single M, move CW");
    is( minTime("n"), 14, "Single N, midpoint");
    is( minTime("o"), 13, "Single N, move CCW");
    is( minTime("aa"), 2, "No movement");

    is( minTime("abc"),   5, "Example 1");
    is( minTime("bza"),   7, "Example 2");
    is( minTime("zjpc"), 34, "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
