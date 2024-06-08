#!perl

################################################################################
=comment

Perl Weekly Challenge 270
=========================

TASK #1
-------
*Special Positions*

Submitted by: Mohammad Sajid Anwar

You are given a m x n binary matrix.

Write a script to return the number of special positions in the given binary
matrix.

    A position (i, j) is called special if $matrix[i][j] == 1 and all other
    elements in the row i and column j are 0.

Example 1

  Input: $matrix = [ [1, 0, 0],
                     [0, 0, 1],
                     [1, 0, 0],
                   ]
  Output: 1

  There is only special position (1, 2) as $matrix[1][2] == 1
  and all other elements in row 1 and column 2 are 0.

Example 2

  Input: $matrix = [ [1, 0, 0],
                     [0, 1, 0],
                     [0, 0, 1],
                   ]
  Output: 3

  Special positions are (0,0), (1, 1) and (2,2).

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
-----------
The input matrix is not empty (i.e., m > 0 and n > 0).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The matrix is entered on the command-line as a series of same-length bit-
   strings, one for each matrix row.
3. If the constant $VERBOSE is set to a true value, the required output (number
   of special positions) is followed by a list of the special positions found.

Reference
---------
Code for handling binary matrices adapted from the Perl solution to Week 242,
Task #2, "Flip Matrix".

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   => <<END;
Usage:
  perl $0 [<matrix> ...]
  perl $0

    [<matrix> ...]    A non-empty m x n binary matrix, e.g., 1100 0110 0010
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 270, Task #1: Special Positions (Perl)\n\n";
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
        my $matrix = parse_matrix( \@ARGV );

        printf "Input: \$matrix = [%s]\n",    join ' ', $matrix->[ 0    ]->@*;

        for my $row (1 .. $#$matrix)
        {
            printf "                 [%s]\n", join ' ', $matrix->[ $row ]->@*;
        }

        my $positions = find_special_positions( $matrix );
        my $count     = scalar @$positions;

        print "Output: $count\n";

        if ($VERBOSE)
        {
            my $indices = $count == 0 ? 'none' :
                          join ', ',
                          map { sprintf '(%s)', join ', ', @$_ } @$positions;

            printf "\nSpecial position%s: %s\n",
                   ($count == 1 ? '' : 's'), $indices;
        }
    }
}

#-------------------------------------------------------------------------------
sub find_special_positions
#-------------------------------------------------------------------------------
{
    my ($matrix)  = @_;
    my  $cols_end = scalar $matrix->[ 0 ]->@* - 1;
    my  @positions;

    L_ROWS:
    for my $row (0 .. $#$matrix)
    {
        for my $col (0 .. $cols_end)
        {
            next unless $matrix->[ $row ][ $col ] == 1;

            for my $c ($col + 1 .. $cols_end)
            {
                next L_ROWS unless $matrix->[ $row ][ $c ] == 0;
            }

            for my $r (0 .. $#$matrix)
            {
                next if $r == $row;

                next L_ROWS unless $matrix->[ $r ][ $col ] == 0;
            }

            push @positions, [ $row, $col ];
            next L_ROWS;
        }
    }

    return \@positions;
}

#-------------------------------------------------------------------------------
sub parse_matrix
#-------------------------------------------------------------------------------
{
    my  ($rows) = @_;
    my   @row   = split //, $rows->[ 0 ];
    my   $n     = scalar @row;
    my   @matrix;
    push @matrix, [ @row ];

    for my $col (1 .. $#$rows)
    {
        my $row_str = $rows->[ $col ];
        my @row     = split //, $row_str;

        scalar @row == $n or error( 'The input matrix is not rectangular' );

        for (@row)
        {
            / ^ [01] $ /x or error( qq["$_" is not a binary number] );
        }

        push @matrix, [ @row ];
    }

    return \@matrix;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $matrix_str, $expected_str) = split / \| /x, $line;

        for ($test_name, $matrix_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @rows      = split / \s+ /x, $matrix_str;
        my $matrix    = parse_matrix( \@rows );
        my $positions = find_special_positions( $matrix );
        my @expected;

        for (split / \s* ; \s* /x, $expected_str)
        {
            push @expected, [ split / \s+ /x ];
        }

        is_deeply $positions, \@expected, $test_name;
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
Example 1  |100   001   100        |1 2
Example 2  |100   010   001        |0 0; 1 1; 2 2
4x5        |10100 01000 00100 00010|1 1; 3 3
None       |101   010   101   010  |
Singleton 0|0                      |
Singleton 1|1                      |0 0
Same column|00100 00000 00100 00001|3 4
Same row   |0000  1001  0010  0000 |2 2
