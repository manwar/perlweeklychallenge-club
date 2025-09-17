#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 339 Task 2  Peak Point
#=============================================================================
# You are given an array of altitude gain.
# Write a script to find the peak point gained.
#
# Example 1 Input: @gain = (-5, 1, 5, -9, 2)
#           Output: 1
#   start: 0    1st change:  0 + (-5) = -5
#               2nd change: -5 + 1    = -4
#               3rd change: -4 + 5    = 1
#               4th change:  1 + (-9) = -8
#               5th change: -8 + 2    = -6
#   max(0, -5, -4, 1, -8, -6) = 1
#
# Example 2 Input: @gain = (10, 10, 10, -25)
#           Output: 30
#   start: 0    1st change:  0 + 10    = 10
#               2nd change: 10 + 10    = 20
#               3rd change: 20 + 10    = 30
#               4th change: 30 + (-25) = 5
#   max(0, 10, 20, 30, 5) = 30
#
# Example 3 Input: @gain = (3, -4, 2, 5, -6, 1)
#           Output: 6
# Example 4 Input: @gain = (-1, -2, -3, -4)
#           Output: 0
# Example 5 Input: @gain = (-10, 15, 5)
#           Output: 10
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

say peakPoint(@ARGV);

#=============================================================================
sub peakPoint(@gain)
{
    my $peak = my $elevation = 0;
    while ( defined (my $hike = shift @gain) )
    {
        $elevation += $hike;
        $peak = $elevation if $elevation > $peak;
    }
    return $peak;
}

sub pp(@gain)
{
    use List::Util qw/reductions max/;
    return max reductions { $a + $b } 0, @gain;
}

sub runTest
{
    use Test2::V0;

    is( peakPoint( -5,  1,  5,  -9,  2   ) ,  1, "Example 1");
    is( peakPoint( 10, 10, 10, -25       ) , 30, "Example 2");
    is( peakPoint(  3, -4,  2,   5, -6, 1) ,  6, "Example 3");
    is( peakPoint( -1, -2, -3,  -4       ) ,  0, "Example 4");
    is( peakPoint(-10, 15,  5            ) , 10, "Example 5");

    is( pp( -5,  1,  5,  -9,  2   ) ,  1, "pp Example 1");
    is( pp( 10, 10, 10, -25       ) , 30, "pp Example 2");
    is( pp(  3, -4,  2,   5, -6, 1) ,  6, "pp Example 3");
    is( pp( -1, -2, -3,  -4       ) ,  0, "pp Example 4");
    is( pp(-10, 15,  5            ) , 10, "pp Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    my @gain;
    push @gain, rand(100) for 1 .. 200;
    cmpthese($repeat, {
            loop => sub { peakPoint(@gain) },
            reduce => sub { pp(@gain) },
        });
}
