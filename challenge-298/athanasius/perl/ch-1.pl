#!perl

################################################################################
=comment

Perl Weekly Challenge 298
=========================

TASK #1
-------
*Maximal Square*

Submitted by: Mohammad Sajid Anwar

You are given an m x n binary matrix with 0 and 1 only.

Write a script to find the largest square containing only 1's and return its
area.

Example 1

  Input: @matrix = ([1, 0, 1, 0, 0],
                    [1, 0, 1, 1, 1],
                    [1, 1, 1, 1, 1],
                    [1, 0, 0, 1, 0])
  Output: 4

  Two maximal square found with same size marked as 'x':

  [1, 0, 1, 0, 0]
  [1, 0, x, x, 1]
  [1, 1, x, x, 1]
  [1, 0, 0, 1, 0]

  [1, 0, 1, 0, 0]
  [1, 0, 1, x, x]
  [1, 1, 1, x, x]
  [1, 0, 0, 1, 0]

Example 2

  Input: @matrix = ([0, 1],
                    [1, 0])
  Output: 1

  Two maximal square found with same size marked as 'x':

  [0, x]
  [1, 0]

  [0, 1]
  [x, 0]

Example 3

  Input: @matrix = ([0])
  Output: 0

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of same-length, non-empty, binary strings is entered on the
   command-line.

=cut
#===============================================================================

use v5.32;      # Enables strictures
use warnings;
use Const::Fast;
use List::Util  qw( min );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<matrix> ...]
  perl $0

    [<matrix> ...]    A list of same-length binary strings, e.g., 1001 1111 0010
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 298, Task #1: Maximal Square (Perl)\n\n";
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
        my @matrix = @ARGV;
        my $width  = length $matrix[ 0 ];

        for (@matrix)
        {
            / ^ [01]+ $ /x   or error( qq["$_" is not a binary string] );
            length == $width or error( 'Ragged matrix' );
        }

        printf  "Input:  \@matrix = ([%s]", format_row( $matrix[ 0  ] );

        printf "\n                   [%s]", format_row( $matrix[ $_ ] )
            for 1 .. $#matrix;

        print ")\n";

        my $max_square = find_max_square( \@matrix );

        print "Output: $max_square\n";
    }
}

#-------------------------------------------------------------------------------
sub find_max_square
#-------------------------------------------------------------------------------
{
    my ($matrix) = @_;
    my  $rows    = scalar @$matrix;
    my  $cols    = length $matrix->[ 0 ];

    for my $side (reverse 1 .. min( $rows, $cols ))
    {
        for my $row0 (0 .. $rows - $side)
        {
            for my $col0 (0 .. $cols - $side)
            {
                if (is_square( $matrix, $row0, $col0, $side ))
                {
                    return $side * $side;
                }
            }
        }
    }

    return 0;
}

#-------------------------------------------------------------------------------
sub is_square
#-------------------------------------------------------------------------------
{
    my ($matrix, $row0, $col0, $side) = @_;

    for my $row ($row0 .. $row0 + $side - 1)
    {
        return 0 if substr( $matrix->[ $row ], $col0, $side ) =~ / 0 /x;
    }

    return 1;
}

#-------------------------------------------------------------------------------
sub format_row
#-------------------------------------------------------------------------------
{
    my ($row) = @_;

    return join ', ', split //, $row;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $matrix_str, $expected) = split / \| /x, $line;

        for ($test_name, $matrix_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @matrix     = split / \s+ /x, $matrix_str;
        my $max_square = find_max_square( \@matrix );

        is $max_square, $expected, $test_name;
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
Example 1|10100 10111 11111 10010                | 4
Example 2|01 10                                  | 1
Example 3|0                                      | 0
4 x 4    |01111 11111 11111 01111 11110          |16
Sieve    |01010 10101 01010 10101 01010          | 1
Island   |0000000 0000110 0000110 0000000 0000000| 4
