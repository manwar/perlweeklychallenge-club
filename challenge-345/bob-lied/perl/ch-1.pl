#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 345 Task 1
#=============================================================================
# You are given an array of integers, @ints. Find all the peaks in the array,
# A peak is an element that is strictly greater than its left and right
# neighbours. Return the indices of all such peak positions.
# Example 1 Input: @ints = (1, 3, 2)
#           Output: (1)
# Example 2 Input: @ints = (2, 4, 6, 5, 3)
#           Output: (2)
# Example 3 Input: @ints = (1, 2, 3, 2, 4, 1)
#           Output: (2, 4)
# Example 4 Input: @ints = (5, 3, 1)
#           Output: (0)
# Example 5 Input: @ints = (1, 5, 1, 5, 1, 5, 1)
#           Output: (1, 3, 5)
#=============================================================================

use v5.42;


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

say '(', join(", ", peakPos(@ARGV)->@*), ')';

#=============================================================================
sub peakPos(@int)
{
    my @peak = ();
    for my ($i, $n) ( indexed @int )
    {
        my $left  = ( $i == 0     ) ? $n-1 : $int[$i-1];
        my $right = ( $i == $#int ) ? $n-1 : $int[$i+1];
        push @peak, $i if ( $n > $left && $n > $right );
    }
    return \@peak;
}

sub runTest
{
    use Test2::V0;

    is( peakPos(        1,3,2), [    1], "Example 1");
    is( peakPos(    2,4,6,5,3), [    2], "Example 2");
    is( peakPos(  1,2,3,2,4,1), [  2,4], "Example 3");
    is( peakPos(        5,3,1), [    0], "Example 4");
    is( peakPos(1,5,1,5,1,5,1), [1,3,5], "Example 5");

    is( peakPos(      1,2,3,4), [    3], "Uphill");
    is( peakPos(      7,7,7,7), [     ], "Flat");
    is( peakPos(            9), [    0], "Singleton");
    is( peakPos(    3,3,3,8,8), [     ], "Plateau");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
