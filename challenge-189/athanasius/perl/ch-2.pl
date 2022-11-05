#!perl

###############################################################################
=comment

Perl Weekly Challenge 189
=========================

TASK #2
-------
*Array Degree*

Submitted by: Mohammad S Anwar

You are given an array of 2 or more non-negative integers.

Write a script to find out the smallest slice, i.e. contiguous subarray of the
original array, having the degree of the given array.

    The degree of an array is the maximum frequency of an element in the array.

Example 1

  Input: @array = (1, 3, 3, 2)
  Output: (3, 3)

  The degree of the given array is 2.
  The possible subarrays having the degree 2 are as below:
  (3, 3)
  (1, 3, 3)
  (3, 3, 2)
  (1, 3, 3, 2)

  And the smallest of all is (3, 3).

Example 2

  Input: @array = (1, 2, 1, 3)
  Output: (1, 2, 1)

Example 3

  Input: @array = (1, 3, 2, 1, 2)
  Output: (2, 1, 2)

Example 4

  Input: @array = (1, 1, 2, 3, 2)
  Output: (1, 1)

Example 5

  Input: @array = (2, 1, 2, 1, 1)
  Output: (1, 2, 1, 1)

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Assumptions
-----------
The "smallest" slice is the slice with fewest elements (i.e., the shortest),
regardless of the values of the elements.

When two or more same-length slices satisfy the given criteria, the first-found
slice is given as the solution.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common;
use Test::More;

const my $TEST_FIELDS => 3;
const my $USAGE       =>
"Usage:
  perl $0 [<array> ...]
  perl $0

    [<array> ...]    An array of 2 or more non-negative integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 189, Task #2: Array Degree (Perl)\n\n";
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
    elsif ($args == 1)
    {
        error( 'Expected 0 or 2+ arguments, found 1' );
    }
    else
    {
        my @array = parse_command_line();

        printf "Input:  \@array = (%s)\n", join ', ', @array;

        my $slice = find_smallest_slice( \@array );

        printf "Output: (%s)\n", join ', ', @$slice;
    }
}

#------------------------------------------------------------------------------
sub find_smallest_slice
#------------------------------------------------------------------------------
{
    my ($array)    = @_;
    my  $degree    = find_degree( $array );
    my  @min_slice = @$array;
    my  $min_size  = scalar @$array;

    for my $i (0 .. $#$array)
    {
        for my $j ($i .. $#$array)
        {
            my @slice = @{ $array }[ $i .. $j ];
            my $size  = scalar @slice;

            if ($size < $min_size)
            {
                my  $slice_degree = find_degree( \@slice );

                if ($slice_degree == $degree)
                {
                    @min_slice = @slice;
                    $min_size  = $size;
                }
            }
        }
    }

    return \@min_slice;
}

#------------------------------------------------------------------------------
sub find_degree
#------------------------------------------------------------------------------
{
    my ($array) = @_;
    my  %freq;
      ++$freq{ $_ } for @$array;
 
    my $max = 0;

    for my $freq (values %freq)
    {
        $max = $freq if $freq > $max;
    }

    return $max;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    for my $n (@ARGV)
    {
        $n =~ / ^ $RE{num}{int} $ /x
                or error( qq["$n" is not a valid integer] );

        $n >= 0 or error( qq["$n" is negative] );
    }

    return @ARGV;
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

        my ($test_name, $array, $expected) =
            split / , \s* /x, $line, $TEST_FIELDS;

        my @array = split / \s+ /x, $array;
        my $slice = find_smallest_slice( \@array );

        is join( ' ', @$slice ), $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1,   1 3 3 2,              3 3
Example 2,   1 2 1 3,              1 2 1
Example 3,   1 3 2 1 2,            2 1 2
Example 4,   1 1 2 3 2,            1 1
Example 5,   2 1 2 1 1,            1 2 1 1
Whole array, 1 2 3 4 5 1,          1 2 3 4 5 1
Degree 1,    1 2 3 4 5 6 7 8 9 10, 1
