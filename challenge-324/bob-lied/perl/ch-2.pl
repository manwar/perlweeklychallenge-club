#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 324 Task Total XOR
#=============================================================================
# You are given an array of integers.  Write a script to return the sum of
# total XOR for every subset of given array.
#
# Example 1 Input: @ints = (1, 3)
#           Output: 6
#   Subset [1],    total XOR = 1
#   Subset [3],    total XOR = 3
#   Subset [1, 3], total XOR => 1 XOR 3 => 2
#   Sum of total XOR => 1 + 3 + 2 => 6
#
# Example 2 Input: @ints = (5, 1, 6)
#           Output: 28
#   Subset [5],       total XOR = 5
#   Subset [1],       total XOR = 1
#   Subset [6],       total XOR = 6
#   Subset [5, 1],    total XOR => 5 XOR 1 => 4
#   Subset [5, 6],    total XOR => 5 XOR 6 => 3
#   Subset [1, 6],    total XOR => 1 XOR 6 => 7
#   Subset [5, 1, 6], total XOR => 5 XOR 1 XOR 6 => 2
#   Sum of total XOR => 5 + 1 + 6 + 4 + 3 + 7 + 2 => 28
#
# Example 3 Input: @ints = (3, 4, 5, 6, 7, 8)
#           Output: 480
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

say totalXOR(@ARGV);

#=============================================================================
sub totalXOR(@ints)
{
    use Algorithm::Combinatorics  qw/subsets/;
    use List::Util qw/reduce/;

    my $sum = 0;
    for my $subset ( subsets(\@ints) )
    {
        $sum += ( reduce { $a ^ $b } $subset->@* ) // 0;
    }
    return $sum;
}

sub runTest
{
    use Test2::V0;

    is( totalXOR(        1,3),   6, "Example 1");
    is( totalXOR(      5,1,6),  28, "Example 2");
    is( totalXOR(3,4,5,6,7,8), 480, "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
