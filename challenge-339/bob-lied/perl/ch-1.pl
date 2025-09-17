#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2025, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 339 Task 1  Max Diff
#=============================================================================
# You are given an array of integers having four or more elements. Write a
# script to find two pairs of numbers from this list (four numbers total)
# so that the difference between their products is as large as possible.
# In the end return the max difference. With Two pairs (a, b) and (c, d),
# the product difference is (a * b) - (c * d).
# Example 1 Input: @ints = (5, 9, 3, 4, 6)
#           Output: 42
#   Pair 1: (9, 6)  Pair 2: (3, 4)
#   Product Diff: (9 * 6) - (3 * 4) => 54 - 12 => 42
# Example 2 Input: @ints = (1, -2, 3, -4)
#           Output: 10
#   Pair 1: (1, -2) Pair 2: (3, -4)
# Example 3 Input: @ints = (-3, -1, -2, -4)
#           Output: 10
#   Pair 1: (-1, -2) Pair 2: (-3, -4)
# Example 4 Input: @ints = (10, 2, 0, 5, 1)
#           Output: 50
#   Pair 1: (10, 5) Pair 2: (0, 1)
# Example 5 Input: @ints = (7, 8, 9, 10, 10)
#           Output: 44
#   Pair 1: (10, 10) Pair 2: (7, 8)
#=============================================================================

use v5.42;

use List::Util qw/max min/;

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

say maxDiff(@ARGV);

#=============================================================================
sub maxDiff_BF(@int)
{
    my $max = 0;
    for my $w ( 0 .. $#int )
    {
        for my $x ( 0 .. $#int )
        {
            next if $x == $w;
            for my $y ( 0 .. $#int )
            {
                next if $y == $x || $y == $w;
                for my $z ( 0  .. $#int )
                {
                    next if $z == $y || $z == $x || $z == $w;
                    my ($a, $b, $c, $d) = @int[$w,$x,$y,$z];

                    my $diff = max( $a*$b - $c*$d, $c*$d - $a*$b );
                    $max = $diff if $diff > $max;
                }
            }
        }
    }
    return $max;
}

sub maxDiff(@int)
{
    @int = sort { $a <=> $b } @int;

    # Possibilities for maximum product: biggest positive numbers, biggest
    # negative numbers, or biggest positive X biggest negative.
    # Find the biggest magnitude, then discard that pair from the list.
    my $nn = $int[0] * $int[1];
    my $pp = $int[-1] * $int[-2];
    my $np = $int[0] * $int[-1];
    my $largest;
    if ( abs($nn) > abs($pp) )
    {
        if ( abs($nn) > abs($np) )
        {
            $largest = $nn;
            shift @int; shift @int;
        }
        else
        {
            $largest = $np;
            shift @int; pop @int;
        }
    }
    else # pp >= nn
    {
        if ( abs($pp) > abs($np) )
        {
            $largest = $pp;
            pop @int; pop @int;
        }
        else
        {
            $largest = $np;
            shift @int; pop @int;
        }
    }

    if ( $largest < 0 )
    {
        # Make it the second pair (because negating it will add a big number),
        # and find the largest product for the first pair. Again, because the
        # list is sorted, the largest magnitude must come from the pairs on
        # the ends of the list.
        my $aXb = max( $int[0]*$int[1], $int[0]*$int[-1], $int[-2]*$int[-1] );
        return $aXb - $largest;
    }
 
    # Use largest as the first pair for maximum positive contribution.
    # Find the smallest product pair to subtract away.

=begin  BlockComment  # BlockCommentNo_1
    my $cXd = $int[0] * $int[1];
    while ( defined(my $c = shift @int) )
    {
        for my $d ( @int )
        {
            $cXd = $c*$d if ( $c*$d < $cXd );
        }
    }

=end    BlockComment  # BlockCommentNo_1

=cut
    # Sort so smallest integers are on the outside of the array.
    @int = sort { ($a == 0 ? 2 : 1/$a) <=> ($b == 0 ? 2 : 1/$b) } @int;
    # -1/2  - 1/3 -1/4   0  1/4   1/3   1/2
    # ----|------|----|----|---|-----|-----|---
    
    my $cXd = min( $int[0]*$int[1], $int[0]*$int[-1], $int[-2]*$int[-1] );
    return $largest - $cXd;
}

sub runTest
{
    use Test2::V0;

    is( maxDiff( 5,  9,  3,  4,  6),   42, "Example 1");
    is( maxDiff( 1, -2,  3, -4),       10, "Example 2");
    is( maxDiff(-3, -1, -2, -4),       10, "Example 3");
    is( maxDiff(10,  2,  0,  5,  1),   50, "Example 4");
    is( maxDiff( 7,  8,  9, 10, 10),   44, "Example 5");

    is( maxDiff(10, 2, 1, 5, 1), 49, "Example 4 + 1");
    is( maxDiff(10, 2, -1, 5, 1), 52, "Example 4 - 1");
    is( maxDiff(-10, 2, -1, 5, 1), 52, "Example 4 - 10");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
