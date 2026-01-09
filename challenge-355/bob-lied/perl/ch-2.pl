#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 355 Task 2  Mountain Array
#=============================================================================
# You are given an array of integers, @ints.  Write a script to return
# true if the given array is a valid mountain array.
# An array is mountain if and only if:
#   1) arr.length >= 3
#   and
#   2) There exists some i with 0 < i < arr.length - 1 such that:
#   arr[0] < arr[1]     < ... < arr[i - 1] < arr[i]
#   arr[i] > arr[i + 1] > ... > arr[arr.length - 1]
#
# Example 1 Input: @ints = (1, 2, 3, 4, 5) Output: false
# Example 2 Input: @ints = (0, 2, 4, 6, 4, 2, 0) Output: true
# Example 3 Input: @ints = (5, 4, 3, 2, 1) Output: false
# Example 4 Input: @ints = (1, 3, 5, 5, 4, 2) Output: false
# Example 5 Input: @ints = (1, 3, 2) Output: true
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

#say isMountain(@ARGV) ? "true" : "false";
say climb(@ARGV) ? "true" : "false";

#=============================================================================
sub isMountain(@ints)
{
    return false if @ints < 3;
    use List::MoreUtils qw/slide first_index last_index/;
    my @slope = slide {($b-$a) <=> 0 } @ints;

    my $up   = first_index { $_ !=  1 } @slope;
    my $down = last_index  { $_ != -1 } @slope;

    return $up > 0 && $down == $up -1;
}

sub climb(@ints)
{
    return false if @ints < 3;

    my $first  = shift @ints;
    my $second = shift @ints;
    if ( ($second - $first ) <= 0 ) { return false }

    use enum qw(Ascend Descend Fail);
    my $climber = Ascend;

    $first = $second;
    while ( defined($second = shift @ints) )
    {
        my $slope = (($second - $first) <=> 0);
        
        #$logger->debug("climber:$climber SLOPE:$slope ($first $second)");
        if ( $climber == Ascend )
        {
            if    ( $slope  < 0 ) { $climber = Descend }
            elsif ( $slope == 0 ) { $climber = Fail; last }
        }
        elsif ( $climber == Descend )
        {
            if    ( $slope >= 0 )  { $climber = Fail; last }
        }

        $first = $second;
    }
    return $climber == Descend;
}


sub runTest
{
    use Test2::V0;

    is( isMountain(    1,2,3,4,5), false, "Example 1");
    is( isMountain(0,2,4,6,4,2,0),  true, "Example 2");
    is( isMountain(    5,4,3,2,1), false, "Example 3");
    is( isMountain(  1,3,5,5,4,2), false, "Example 4");
    is( isMountain(        1,3,2),  true, "Example 5");
    is( isMountain(      2,2,2,2), false, "Plateau");
    is( isMountain(          2,5), false, "Too small");
    is( isMountain(1..99, reverse(1..98)), true, "Big rock candy mountain");

    is( climb(    1,2,3,4,5), false, "Example 1 climb");
    is( climb(0,2,4,6,4,2,0),  true, "Example 2 climb");
    is( climb(    5,4,3,2,1), false, "Example 3 climb");
    is( climb(  1,3,5,5,4,2), false, "Example 4 climb");
    is( climb(        1,3,2),  true, "Example 5 climb");
    is( climb(      2,2,2,2), false, "Plateau climb");
    is( climb(          2,5), false, "Too small climb");
    is( climb(1..99, reverse(1..98)), true, "Big rock candy mountain");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
        search => sub { isMountain(1..500, reverse(1..98)) },
        state => sub { climb(1..500, reverse(1..98)) },
        });
}
