#!perl

################################################################################
=comment

Perl Weekly Challenge 211
=========================

TASK #2
-------
*Split Same Average*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out if the given can be split into two separate arrays
whose average are the same.

Example 1:

  Input: @nums = (1, 2, 3, 4, 5, 6, 7, 8)
  Output: true

  We can split the given array into (1, 4, 5, 8) and (2, 3, 6, 7).
  The average of the two arrays are the same i.e. 4.5.

Example 2:

  Input: @list = (1, 3)
  Output: false

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value, an output of "True" is followed by an
   explanation of how the array may be split (using the first solution found).

Notes
-----
1. Duplicates are allowed in the input array.
2. Where more than one solution is possible, the preferred solution is the one
   in which the partitions are closest in size.
3. The algorithm used is a simple search of all possible partitions formed from
   members of the input array; obviously, for larger arrays, this will not scale
   well.

=cut
#===============================================================================

use strict;
use warnings;
use experimental      qw( smartmatch );
use Const::Fast;
use Math::Prime::Util qw( forcomb lastfor );
use Regexp::Common    qw( number );
use Test::More;

const my $EPSILON => 10 ** -9;
const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<nums> ...]
  perl $0

    [<nums> ...]    A list of integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 211, Task #2: Split Same Average (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        / ^ $RE{num}{int} $ /x
            or die qq[ERROR: "$_" is not a valid integer\n$USAGE]
                for @ARGV;

        printf "Input:  \@list = (%s)\n", join ', ', @ARGV;

        my $solution = split_same_avg( \@ARGV );

        printf "Output: %s\n", $solution->[ 0 ] ? 'True' : 'False';

        if ($VERBOSE && $solution->[ 0 ])
        {
            printf "\nWe can split the given array into (%s) and (%s)\n",
                join( ', ', $solution->[ 1 ]->@* ),
                join( ', ', $solution->[ 2 ]->@* );

            print 'The average of each of these arrays is ' . $solution->[ 3 ] .
                  "\n";
        }
    }
}

#-------------------------------------------------------------------------------
sub split_same_avg
#-------------------------------------------------------------------------------
{
    my ($nums) = @_;

    if (scalar @$nums >= 2)
    {
        my $found = 0;

        # Prefer the solution in which the partitions are closest in size

        for my $k (reverse 1 .. int( scalar( @$nums ) / 2 ))
        {
            my (@part1, @part2, $avg1, $avg2);

            forcomb
            {
                @part1 = (@$nums)[ @_ ];
                @part2 = complement( $nums, \@part1 );
                $avg1  = average( \@part1 );
                $avg2  = average( \@part2 );

                $found = 1, lastfor if abs($avg1 - $avg2) < $EPSILON;

            } @$nums, $k;

            if ($found)
            {
                @part1 = sort { $a <=> $b } @part1;
                @part2 = sort { $a <=> $b } @part2;

                return [ 1, \@part1, \@part2, $avg1 ];
            }
        }
    }

    return [ 0, undef, undef, undef ];
}

#-------------------------------------------------------------------------------
sub complement
#-------------------------------------------------------------------------------
{
    my ($uni_ref, $bag_ref) = @_;

    my  @uni = sort { $a <=> $b } @$uni_ref;
    my  @bag = sort { $a <=> $b } @$bag_ref;
    my  @comp;

    while (@uni && @bag)
    {
        my  $elem = shift @uni;

        if ($elem == $bag[ 0 ])
        {
            shift @bag;
        }
        else
        {
            push  @comp, $elem;
        }
    }

    push @comp, @uni;

    return @comp;
}

#-------------------------------------------------------------------------------
sub average
#-------------------------------------------------------------------------------
{
    my ($list) = @_;
    my  $elems = scalar @$list;

    return if $elems == 0;

    my $sum  = 0;
       $sum += $_ for @$list;

    return $sum / $elems;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $input, @output) = split / \| /x, $line;

        for ($test_name, $input, @output)           # Trim whitespace
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @nums     = split / \, \s* /x, $input;
        my $expected = $output[ 0 ];
        my $got      = split_same_avg( \@nums );

        is  $got->[ 0 ], $expected, $test_name;

        if ($got->[ 0 ] && $expected)
        {
            my @part1 = split / \, \s* /x, $output[ 1 ];
            my @part2 = split / \, \s* /x, $output[ 2 ];
            my $avg   = $output[ 3 ];

            ok $got->[ 1 ] ~~ @part1, "$test_name: partition 1";
            ok $got->[ 2 ] ~~ @part2, "$test_name: partition 2";
            is $got->[ 3 ],   $avg,   "$test_name: average";
        }
    }

    done_testing;
}

################################################################################

# Note: The specific solution to Example 1 has been changed in accordance with
#       the algorithm used in split_same_avg()

__DATA__
Example 1| 1, 2, 3, 4, 5, 6, 7, 8|1| 1, 2, 7, 8| 3, 4, 5, 6| 4.5
Example 2| 1, 3                  |0
Negatives|-4,-2,-3               |1|-3         |-4,-2      |-3
Mixed 1  |-7, 5, 0, 9,12,-1, 4, 6|1|-7, 4, 5,12|-1, 0, 6, 9| 3.5
Mixed 2  |-7, 5, 0, 9,12,-1, 4, 5|0
Same     | 4, 4                  |1| 4         | 4         | 4
Zeros    | 0, 0, 0               |1| 0         | 0, 0      | 0
One      |42                     |0
