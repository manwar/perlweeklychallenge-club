#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 320 Task 1 Maximum Count
#=============================================================================
# You are given an array of integers.  Write a script to return the maximum
# between the number of positive and negative integers. Zero is neither
# positive nor negative.
# Example 1 Input: @ints = (-3, -2, -1, 1, 2, 3)
#           Output: 3
# Example 2 Input: @ints = (-2, -1, 0, 0, 1)
#           Output: 2
# Example 3 Input: @ints = (1, 2, 3, 4)
#           Output: 4
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

say maxCount(@ARGV);

#=============================================================================
sub maxCount(@ints)
{
    my @sign = (0,0,0);

    $sign[ $_ <=> 0 ]++ for @ints;

    return $sign[1] > $sign[-1] ? $sign[1] : $sign[-1];
}

sub runTest
{
    use Test2::V0;

    is( maxCount(-3,-2,-1,1,2,3), 3, "Example 1");
    is( maxCount(-2,-1,0,0,1),    2, "Example 2");
    is( maxCount(1,2,3,4),        4, "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
