#!perl

###############################################################################
=comment

Perl Weekly Challenge 199
=========================

TASK #2
-------
*Good Triplets*

Submitted by: Mohammad S Anwar

You are given an array of integers, @array and three integers $x,$y,$z.

Write a script to find out total Good Triplets in the given array.

A triplet array[i], array[j], array[k] is good if it satisfies the following
conditions:

  a) 0 <= i < j < k <= n (size of given array)
  b) abs(array[i] - array[j]) <= x
  c) abs(array[j] - array[k]) <= y
  d) abs(array[i] - array[k]) <= z

Example 1

  Input: @array = (3,0,1,1,9,7) and $x = 7, $y = 2, $z = 3
  Output: 4

  Good Triplets are as below:
  (3,0,1) where (i=0, j=1, k=2)
  (3,0,1) where (i=0, j=1, k=3)
  (3,1,1) where (i=0, j=2, k=3)
  (0,1,1) where (i=1, j=2, k=3)

Example 2

  Input: @array = (1,1,2,2,3) and $x = 0, $y = 0, $z = 1
  Output: 0

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
1. If no command-line argument is given, the test suite is run. Otherwise:
2. N.B.: $x, $y, $z must appear on the command line (in that order) BEFORE the
   elements of @array.
3. If $VERBOSE is set to a true value, an explanation like that in Example 1 is
   appended to the solution.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $TEST_FIELDS => 3;
const my $VERBOSE     => 1;
const my $USAGE       =>
"Usage:
  perl $0 <x> <y> <z> [<array> ...]
  perl $0

    <x>              An integer
    <y>              An integer
    <z>              An integer
    [<array> ...]    A list of integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 199, Task #2: Good Triplets (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args <  3)
    {
        error( "Expected 0 or 3+ arguments, found $args" );
    }
    else
    {
        for (@ARGV)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        }

        my ($x, $y, $z, @array) = @ARGV;

        printf "Input:  \@array = (%s) and \$x = %d, \$y = %d, \$z = %d\n",
                join( ',', @array ), $x, $y, $z;

        my $triplets = find_good_triplets( $x, $y, $z, \@array );

        printf "Output: %d\n", scalar @$triplets;

        give_details( \@array, $triplets ) if $VERBOSE;
    }
}

#------------------------------------------------------------------------------
sub find_good_triplets
#------------------------------------------------------------------------------
{
    my ($x, $y, $z, $array) = @_;
    my  @triplets;

    for my $i (0 .. $#$array - 2)
    {
        for my $j ($i + 1 .. $#$array - 1)
        {
            if (abs( $array->[ $i ] - $array->[ $j ] ) <= $x)
            {
                for my $k ($j + 1 .. $#$array)
                {
                    if (abs( $array->[ $j ] - $array->[ $k ] ) <= $y &&
                        abs( $array->[ $i ] - $array->[ $k ] ) <= $z)
                    {
                        push @triplets, [ $i, $j, $k ];
                    }
                }
            }
        }
    }

    return \@triplets;
}

#------------------------------------------------------------------------------
sub give_details
#------------------------------------------------------------------------------
{
    my ($array, $triplets) = @_;
    my  $count = scalar @$triplets;

    if    ($count == 0)
    {
        print "\nThere are no good triplets in the array\n";
    }
    elsif ($count == 1)
    {
        print "\nThere is 1 good triplet in the array:\n";

        my @indices = @{ $triplets->[ 0 ] };

        printf "(%s) where (i=%d, j=%d, k=%d)\n",
                join( ',', (@$array)[ @indices ] ), @indices;
    }
    else
    {
        print "\nThere are $count good triplets in the array:\n";

        for (@$triplets)
        {
            printf "(%s) where (i=%d, j=%d, k=%d)\n",
                    join( ',', (@$array)[ @$_ ] ), @$_;
        }
    }
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $in, $expected) = split / \| /x, $line, $TEST_FIELDS;

        s/ ^ \s* (.+?) \s* $ /$1/x                            # Trim whitespace
            for $test_name, $in, $expected;

        my ($x, $y, $z, @array) = split / , /x, $in;

        my  $triplets = find_good_triplets( $x, $y, $z, \@array );

        is scalar @$triplets, $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1|7,2,3,3,0,1,1,9,7|4
Example 2|0,0,1,1,1,2,2,3  |0
Single   |7,2,3,3,0,1      |1
