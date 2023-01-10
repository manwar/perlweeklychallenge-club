#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 199 Task 2 Good Triplets
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers, @array and three integers $x,$y,$z.
# Write a script to find out total Good Triplets in the given array.
# A triplet array[i], array[j], array[k] is good if it satisfies the
# following conditions:
#   a) 0 <= i < j < k <= n (size of given array)
#   b) abs(array[i] - array[j]) <= x
#   c) abs(array[j] - array[k]) <= y
#   d) abs(array[i] - array[k]) <= z
#
# Example 1
# Input: @array = (3,0,1,1,9,7) and $x = 7, $y = 2, $z = 3
# Output: 4
#   Good Triplets are as below:
#   (3,0,1) where (i=0, j=1, k=2) 3-0 <= 7, 1-0 <= 2, 1-0 <= 3
#   (3,0,1) where (i=0, j=1, k=3)
#   (3,1,1) where (i=0, j=2, k=3) 3-1 <= 7, 3-1 <= 2, 1-1 <= 3
#   (0,1,1) where (i=1, j=2, k=3) 1-0 <= 7, 1-0 <= 2, 1-1 <= 3
#
# Example 2
# Input: @array = (1,1,2,2,3) and $x = 0, $y = 0, $z = 1
# Output: 0
#=============================================================================

use v5.36;

use List::Util qw/all/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub usage() { "Usage: $0 '1,2,3...' x y z" }

my ($a, $x, $y, $z) = @ARGV;
die usage() unless all { defined $_ } $a, $x, $y, $z;
die ( usage() . "x y z positive integers") unless all { m/[0-9]+/ } $x, $y, $z;

$a =~ s/[[:punct:]]/ /g;
my @array = split ' ', $a;

say "array=[@array] x=$x y=$y z=$z" if $Verbose;

say goodTriplets( \@array, $x, $y, $z);

sub showTriple($a, $i, $j, $k)
{
    my $s = sprintf("[%3d, %3d, %3d]", $i, $j, $k);
    $s .=   sprintf(" %3d  %3d  %3d ", $a->@[$i, $j, $k]);
    return $s
}

sub goodTriplets($array, $x, $y, $z)
{
    my $len = scalar(@$array);
    my $count = 0;
    # We have to leave room for j and k, so we can skip last two
    for ( my $i = 0 ; $i < ($len-2) ; $i++ )
    {
        for (my $j = $i + 1; $j < ($len-1) ; $j++ )
        {
            next unless ( abs( $array->[$i] - $array->[$j] ) <= $x );
            for ( my $k = $j + 1; $k < $len ; $k++ )
            {
                if (   abs( $array->[$j] - $array->[$k] ) <= $y
                    && abs( $array->[$i] - $array->[$k] ) <= $z
                   )
                {
                    say showTriple($array, $i, $j, $k) if $Verbose;
                    $count++;
                }
            }
        }
    }
    return $count;
}

sub runTest
{
    use Test2::V0;

    is( goodTriplets( [ 3,0,1,1,9,7 ], 7,2,3 ),   4, "Example 1");
    is( goodTriplets( [ 1,1,2,2,3   ], 0,0,1 ),   0, "Example 2");
    is( goodTriplets( [             ], 1,2,3 ),   0, "Empty array");
    is( goodTriplets( [ 1           ], 1,2,3 ),   0, "array of 1");
    is( goodTriplets( [ 1,2         ], 1,2,3 ),   0, "array of 2");
    is( goodTriplets( [ 1,2,3       ], 1,2,3 ),   1, "array of 3");
    is( goodTriplets( [ 1,2,7       ], 1,2,3 ),   0, "array of 3 fail");
    is( goodTriplets( [ 1,1,1,1     ], 0,0,0 ),   4, "zero diffs");
    is( goodTriplets( [ 1,3,5,7,9   ], 2,2,3 ),   0, "two diffs, 0");
    is( goodTriplets( [ 1,3,5,7,9   ], 2,2,4 ),   3, "two diffs, 2");
    is( goodTriplets( [ 1,3,5,7,9   ], 2,2,4 ),   3, "two diffs, 3");
    is( goodTriplets( [ 1 .. 100    ], 2,2,4 ), 388, "one hundred");

    done_testing;
}

