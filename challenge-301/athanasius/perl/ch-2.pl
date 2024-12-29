#!perl

################################################################################
=comment

Perl Weekly Challenge 301
=========================

TASK #2
-------
*Hamming Distance*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return the sum of Hamming distances between all the pairs of
the integers in the given array of integers.

  The Hamming distance between two integers is the number of places in which
  their binary representations differ.

Example 1

  Input: @ints = (4, 14, 2)
  Output: 6

  Binary representation:
  4  => 0100
  14 => 1110
  2  => 0010

  HammingDistance(4, 14) + HammingDistance(4, 2) + HammingDistance(14, 2) = 2 +
  2 + 2 = 6.

Example 2

  Input: @ints = (4, 14, 4)
  Output: 4

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The given integers are unsigned.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of unsigned integers is entered on the command-line.


=cut
#===============================================================================

use v5.32;         # Enables strictures and warnings
use Const::Fast;
use List::Util     qw( max );
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of unsigned integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 301, Task #2: Hamming Distance (Perl)\n\n";
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
        my @ints = @ARGV;

        for (@ints)
        {
           / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
           $_ > 0                 or error( "$_ is negative" );
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $sum = find_sum_of_distances( \@ints );

        print  "Output: $sum\n";
    }
}

#-------------------------------------------------------------------------------
sub find_sum_of_distances
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  $sum   = 0;

    for my $i (0 .. $#$ints - 1)
    {
        for my $j ($i + 1 .. $#$ints)
        {
            $sum += hamming_distance( $ints->[ $i ], $ints->[ $j ] );
        }
    }

    return $sum;
}

#-------------------------------------------------------------------------------
sub hamming_distance
#-------------------------------------------------------------------------------
{
    my ($p, $q) = @_;
    my  $count  = 0;
    my  $bin_p  = sprintf '%b', $p;
    my  $bin_q  = sprintf '%b', $q;
    my  $max_c  = max( length $bin_p, length $bin_q );

    # Prepend zeros to make the binary representations the same length

    $_ = '0' x ($max_c - length) . $_ for $bin_p, $bin_q;

    for my $i (0 .. $max_c - 1)
    {
        ++$count unless substr( $bin_p, $i, 1 ) eq substr( $bin_q, $i, 1 );
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $expected) = split / \| /x, $line;

        for ($test_name, $ints_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints = split / \s+ /x, $ints_str;
        my $sum  = find_sum_of_distances( \@ints );

        is $sum, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1|4 14 2|6
Example 2|4 14 4|4
