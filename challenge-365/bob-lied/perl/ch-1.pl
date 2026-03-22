#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 365 Task 1  Alphabet Index Digit Sum
#=============================================================================
# You are given a string $str consisting of lowercase English letters, and an
# integer $k. Write a script to convert a lowercase string into numbers using
# alphabet positions (a=1 … z=26), concatenate them to form an integer, then
# compute the sum of its digits repeatedly $k times, returning the final value.
# Example 1 Input: $str = "abc", $k = 1
#           Output: 6
#   Conversion: a = 1, b = 2, c = 3 -> 123
#   Digit sum: 1 + 2 + 3 = 6
# Example 2 Input: $str = "az", $k = 2
#           Output: 9
#   Conversion: a = 1, z = 26 -> 126;  1 + 2 + 6 = 9, 2nd sum: 9
# Example 3 Input: $str = "cat", $k = 1
#           Output: 6
#   Conversion: c = 3, a = 1, t = 20 -> 3120; 3 + 1 + 2 + 0 = 6
# Example 4 Input: $str = "dog", $k = 2
#           Output: 8
# Example 5 Input: $str = "perl", $k = 3
#           Output: 6
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;
my $K = 1;

GetOptions("k" => \$K, "test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
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

say aids($_, $K) for @ARGV;

#=============================================================================
sub aids($str, $k)
{
    use List::Util qw/sum0/;
    my $n = join "" => map { ord($_) - ord("a") + 1 } split(//, $str);
    while ( $k-- && $n >= 10 )
    {
        $n = sum0 split(//, $n);
    }
    return $n;
}

sub runTest
{
    use Test2::V0;

    is( aids("abc",  1), 6, "Example 1");
    is( aids("az",   2), 9, "Example 2");
    is( aids("cat",  1), 6, "Example 3");
    is( aids("dog",  2), 8, "Example 4");
    is( aids("perl", 3), 6, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
