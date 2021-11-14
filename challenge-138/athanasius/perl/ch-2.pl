#!perl

###############################################################################
=comment

Perl Weekly Challenge 138
=========================

TASK #2
-------
*Split Number*

Submitted by: Mohammad S Anwar

You are given a perfect square.

Write a script to figure out if the square root the given number is same as sum
of 2 or more splits of the given number.

Example 1

 Input: $n = 81
 Output: 1

 Since, sqrt(81) = 8 + 1

Example 2

 Input: $n = 9801
 Output: 1

Since, sqrt(9801) = 98 + 0 + 1

 Example 3

 Input: $n = 36
 Output: 0

 Since, sqrt(36) != 3 + 6

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
Output is as per the Examples, except that $n's square root is also given. If a
simpler output (with no square root and no explanation) is desired, set the
constant $VERBOSE to a false value.

Algorithm
---------
The partitioning of "$n" into its possible substrings is accomplished by the
recursive subroutine _get_splits_recursive(), which is adapted from the C++
implementation in "Print all ways to break a string in bracket form" at:
https://www.geeksforgeeks.org/print-ways-break-string-bracket-form/.

Performance
-----------
A string of length s may be partitioned in 2 ^ (s - 1) different ways. For long
strings (i.e., high values of $n), it may be expected that this will incur
significant memory usage. In practice (by which I mean: by my observations
using the Windows Task Manager), memory usage begins to become noticeably large
only when $n reaches 19 digits in length.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 <n>

    <n>    A perfect square\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 138, Task #2: Split Number (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my ($n)   = parse_command_line();
    my  $root = sqrt $n;

    printf "Input:  \$n = %d%s\n", $n, $VERBOSE ? " (sqrt $root)" : '';

    my @splits   = get_splits( $n );
    my @solution = find_solution( $root, \@splits );

    printf "Output: %d\n", scalar @solution > 0 ? 1 : 0;

    if ($VERBOSE)
    {
        if (scalar @solution > 0)
        {
            printf qq[\nSince "%d" can be split into %s = %d\n],
                      $n, join( ' + ', @solution ), $root;
        }
        else
        {
            print  qq[\nSince no split of "$n" sums to $root\n];
        }
    }
}

#------------------------------------------------------------------------------
sub find_solution
#------------------------------------------------------------------------------
{
    my ($root, $splits) = @_;
    my  @solution;

    for my $split (@$splits)
    {
        my $sum  = 0;
           $sum += $_ for @$split;

        if ($sum == $root)
        {
            @solution = @$split;
            last;
        }
    }

    return @solution;   # The first partition of $n (if any) that sums to $root
}

#==============================================================================
# Partition a number
#==============================================================================
{
    my @partitions;

    #--------------------------------------------------------------------------
    sub get_splits
    #--------------------------------------------------------------------------
    {
        my ($n) = @_;

        # (1) Find all possible unique partitions of the string "$n"

        _get_splits_recursive( $n, 0, [] );

        # (2) Weed out multi-digit numbers beginning with zero

        my @splits;

        OUTER:
        for my $comb (@partitions)
        {
            for my $seg (@$comb)
            {
                next OUTER if $seg =~ / ^ 0 \d /x;
            }

            push @splits, $comb;
        }

        return @splits;
    }

    #--------------------------------------------------------------------------
    # Adapted from "Print all ways to break a string in bracket form",
    # https://www.geeksforgeeks.org/print-ways-break-string-bracket-form/
    # (C++ implementation)
    #
    sub _get_splits_recursive
    #--------------------------------------------------------------------------
    {
        my ($str, $index, $out) = @_;

        if ($index == length $str)                            # Base case
        {
            push @partitions, $out;
        }
        else                                                  # Recursive cases
        {
            for my $i ($index .. length( $str ) - 1)
            {
                _get_splits_recursive
                (
                    $str,
                    $i + 1,
                    [ @$out, substr( $str, $index, $i + 1 - $index ) ]
                );
            }
        }
    }
} # End partition block

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $args = scalar @ARGV;
       $args == 1 or error( "Expected 1 command line argument, found $args" );

    my $n = $ARGV[ 0 ];

    $n =~ / ^ $RE{num}{int} $ /x
                  or error( qq["$n" is not a valid integer] );

    $n >= 0       or error( 'A negative number cannot be a perfect square' );

    my $root = int sqrt $n;

    $root * $root == $n
                  or error( "$n is not a perfect square" );

    return $n;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
