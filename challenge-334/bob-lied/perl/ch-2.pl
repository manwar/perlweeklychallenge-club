#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 334 Task 2  Nearest Valid Point
#=============================================================================
# You are given current location as two integers: x and y. You are also
# given a list of points on the grid. A point is considered valid if it
# shares either the same x-coordinate or the same y-coordinate as the
# current location.  Write a script to return the index of the valid point
# that has the smallest Manhattan distance to the current location.
# If multiple valid points are tied for the smallest distance, return
# the one with the lowest index. If no valid points exist, return -1.
# The Manhattan distance between two points (x1, y1) and (x2, y2)
# is calculated as: |x1 - x2| + |y1 - y2|
#
# Example 1 Input: $x = 3, $y = 4, @points ([1, 2], [3, 1], [2, 4], [2, 3])
#           Output: 2
#   Valid points: [3, 1] (same x), [2, 4] (same y)
#   Manhattan distances: [3, 1] => |3-3| + |4-1| = 3
#                        [2, 4] => |3-2| + |4-4| = 1
#   Closest valid point is [2, 4] at index 2.
#
# Example 2 Input: $x = 2, $y = 5, @points ([3, 4], [2, 3], [1, 5], [2, 5])
#           Output: 3
# Example 3 Input: $x = 1, $y = 1, @points ([2, 2], [3, 3], [4, 4])
#           Output: -1
#   No point shares x or y with (1, 1).
# Example 4 Input: $x = 0, $y = 0, @points ([0, 1], [1, 0], [0, 2], [2, 0])
#           Output: 0
# Example 5 Input: $x = 5, $y = 5, @points ([5, 6], [6, 5], [5, 4], [4, 5])
#           Output: 0
#=============================================================================

use v5.42;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

my $X = 0;
my $Y = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark,
            "x:i" => \$X, "y:i" => \$Y);
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

# Usage: perl ch-2.pl -x 0 -y 0  1,1  2,0  0,3  1,1
my @POINT = map { [split(',', $_)] } @ARGV;
say nvp($X, $Y, \@POINT);

#=============================================================================
sub nvp($x, $y, $point)
{
    my $minIndex;
    my $minDistance;
    for my ($i, $p)  (indexed reverse @$point)
    {
        next unless $p->[0] == $x || $p->[1] == $y;
        
        
        # Literally: my $d = abs($x - $p->[0]) + abs( $y - $p->[1] );
        # We only need to do one abs() call because one of those differences
        # must be zero.
        my $d = abs($x - $p->[0] + $y - $p->[1] );
        $minDistance //= $d;
        if ( $d <= $minDistance )
        {
            $minIndex = $i;
            $minDistance = $d;
        }
    }
    return $minIndex // -1;
}

sub runTest
{
    use Test2::V0;

    is( nvp(3,4, [ [1, 2], [3, 1], [2, 4], [2, 3] ]),  2, "Example 1");
    is( nvp(2,5, [ [3, 4], [2, 3], [1, 5], [2, 5] ]),  3, "Example 2");
    is( nvp(1,1, [ [2, 2], [3, 3], [4, 4]         ]), -1, "Example 3");
    is( nvp(0,0, [ [0, 1], [1, 0], [0, 2], [2, 0] ]),  0, "Example 4");
    is( nvp(5,5, [ [5, 6], [6, 5], [5, 4], [4, 5] ]),  0, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

