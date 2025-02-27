#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 310 Task 2 Sort Odd Even
#=============================================================================
# You are given an array of integers.
# Write a script to sort odd index elements in decreasing order and even
# index elements in increasing order in the given array.
# Example 1 Input: @ints = (4, 1, 2, 3)
#           Output: (2, 3, 4, 1)
#   Even index elements: 4, 2 => 2, 4 (increasing order)
#   Odd index elements : 1, 3 => 3, 1 (decreasing order)
# Example 2 Input: @ints = (3, 1)
#           Output: (3, 1)
# Example 3 Input: @ints = (5, 3, 2, 1, 4)
#           Output: (2, 3, 4, 1, 5)
#   Even index elements: 5, 2, 4 => 2, 4, 5 (increasing order)
#   Odd index elements : 3, 1 => 3, 1 (decreasing order)
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

say sortoe(@ARGV);

#=============================================================================
sub sortoe(@ints)
{
    my @even = sort { $a <=> $b } @ints[ map { $_ * 2     } 0 .. int($#ints/2) ];
    my @odd  = sort { $b <=> $a } @ints[ map { $_ * 2 + 1 } 0 .. int(($#ints-1)/2) ];
    my @sorted;
    while ( @even && @odd ) { push @sorted, ( shift @even, shift @odd ) }
    push @sorted, shift @even if @even;
    return \@sorted;
}

sub runTest
{
    use Test2::V0;

    is( sortoe(4,1,2,3),   [  2,3,4,1], "Example 1");
    is( sortoe(3,1),       [      3,1], "Example 2");
    is( sortoe(5,3,2,1,4), [2,3,4,1,5], "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
