#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 309 Task 2 Min Diff
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to find the minimum difference between any two elements.
# Example 1 Input: @ints = (1, 5, 8, 9)
#           Output: 1
#   1, 5 => 5 - 1 => 4
#   1, 8 => 8 - 1 => 7
#   1, 9 => 9 - 1 => 8
#   5, 8 => 8 - 5 => 3
#   5, 9 => 9 - 5 => 4
#   8, 9 => 9 - 8 => 1
#
# Example 2 Input: @ints = (9, 4, 1, 7)
#           Output: 2
#   Minimum difference of pairs is 9-7
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

say minDiff(@ARGV);

#=============================================================================
sub minDiff(@ints)
{
    return undef if @ints < 2;
    my $smallest = abs($ints[1] - $ints[0]);
    while ( defined(my $first = shift @ints) )
    {
        for my $second ( @ints )
        {
            my $diff = abs($second - $first);
            $smallest = $diff if $diff < $smallest;
        }
    }
    return $smallest;
}

sub runTest
{
    use Test2::V0;

    is( minDiff(1,5,8,9), 1, "Example 1");
    is( minDiff(9,4,1,7), 2, "Example 2");
    is( minDiff(9,8,1,5), 1, "Min at start");
    is( minDiff(9,7,5,4), 1, "Min at end");
    is( minDiff(9,7,5,3), 2, "Multiple min");
    is( minDiff(0,0,0,0), 0, "All same zero");
    is( minDiff(4,4,4,4), 0, "All same non-zero");
    is( minDiff(),    undef, "Empty list");
    is( minDiff(5),   undef, "List of one");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
