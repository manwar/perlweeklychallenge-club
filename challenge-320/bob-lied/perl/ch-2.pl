#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 320 Task 2 Sum Difference
#=============================================================================
# You are given an array of positive integers.  Write a script to return the
# absolute difference between digit sum and element sum of the given array.
# Example 1 Input: @ints = (1, 23, 4, 5)
#           Output: 18
#   Element sum: 1 + 23 + 4 + 5 => 33
#   Digit sum: 1 + 2 + 3 + 4 + 5 => 15
#   Absolute difference: | 33 - 15 | => 18
# Example 2 Input: @ints = (1, 2, 3, 4, 5)
#           Output: 0
# Example 3 Input: @ints = (1, 2, 34)
#           Output: 27
#=============================================================================

use v5.40;


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

say sumDiff(@ARGV);

#=============================================================================
sub sumDiff(@ints)
{
    my $diff = 0;
    for my $n ( @ints )
    {
        $diff += $n;
        while ( $n )
        {
            use integer;
            $diff -= $n % 10;
            $n /= 10;
        }
    }

    return abs($diff);
}

sub runTest
{
    use Test2::V0;

    is( sumDiff(1,23,4,5 ), 18, "Example 1");
    is( sumDiff(1,2,3,4,5),  0, "Example 2");
    is( sumDiff(1,2,34   ), 27, "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
