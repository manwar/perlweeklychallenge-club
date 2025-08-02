#!perl

################################################################################
=comment

Perl Weekly Challenge 266
=========================

TASK #2
-------
*X Matrix*

Submitted by: Mohammad Sajid Anwar

You are given a square matrix, $matrix.

Write a script to find if the given matrix is X Matrix.

    A square matrix is an X Matrix if all the elements on the main diagonal and
    antidiagonal are non-zero and everything else are zero.

Example 1

  Input: $matrix = [ [1, 0, 0, 2],
                     [0, 3, 4, 0],
                     [0, 5, 6, 0],
                     [7, 0, 0, 1],
                   ]
  Output: true

Example 2

  Input: $matrix = [ [1, 2, 3],
                     [4, 5, 6],
                     [7, 8, 9],
                   ]
  Output: false

Example 3

  Input: $matrix = [ [1, 0, 2],
                     [0, 3, 0],
                     [4, 0, 5],
                   ]
  Output: true

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Matrix elements are integers.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input matrix is entered on the command-line as a non-empty list of
   strings (the matrix rows) containing elements separated by whitespace. For
   example, the matrix:

        [ 1 1 0 ]
        [ 0 1 0 ]
        [ 0 0 0 ]

    is entered as: >perl ch-2.pl "1 1 0" "0 1 0" "0 0 1"

Note
----
Matrix-handling code is adapted from the solutions to Task 2 for Week 248 and
Task 2 for Week 257.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<matrix> ...]
  perl $0

    [<matrix> ...]    A square and non-empty integer matrix
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 266, Task #2: X Matrix (Perl)\n\n";
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

        print_matrix( 'Input:  $matrix = ', $matrix );

        my $x_matrix = is_x_matrix( $matrix );

        printf "Output: %s\n", $x_matrix ? 'true' : 'false';
    }
}

#-------------------------------------------------------------------------------
sub is_x_matrix
#-------------------------------------------------------------------------------
{
    my ($matrix) = @_;
    my  $end = $#$matrix;

    for my $row (0 .. $end)
    {
        for my $col (0 .. $end)
        {
            if ($row        == $col ||          # On the main diagonal
                $row + $col == $end)            # On the antidiagonal
            {
                return 0 if     $matrix->[ $row ][ $col ] == 0;
            }
            else
            {
                return 0 unless $matrix->[ $row ][ $col ] == 0;
            }
        }
    }

    return 1;
}

#-------------------------------------------------------------------------------
sub parse_matrix
#-------------------------------------------------------------------------------
{
    my ($rows) = @_;
    my (@matrix, $cols);

    for my $row_str (@$rows)
    {
        my @row;

        for my $elem (grep { / \S /x } split / \s+ /x, $row_str)
        {
            if ($elem =~ / ^ $RE{num}{int} $ /x)
            {
                push @row, $elem;
            }
            else
            {
                error( qq[Element "$elem" is not a valid integer] );
            }
        }

        scalar @row > 0 or error( 'Empty row' );
        push   @matrix, \@row;

        if (defined $cols)
        {
            scalar @row == $cols   or error( 'The input matrix is ragged' );
        }
        else    # Initialize $cols
        {
            $cols =  scalar @row;
            $cols == scalar @$rows or error( 'The input matrix is not square' );
        }
    }

    return \@matrix;
}

#-------------------------------------------------------------------------------
sub print_matrix
#-------------------------------------------------------------------------------
{
    my ($prefix, $matrix) = @_;
    my  $tab   = ' ' x length $prefix;
    my  @width = (1) x scalar @{ $matrix->[ 0 ] };

    for my $row (@$matrix)
    {
        for my $i (0 .. $#$row)
        {
            my $w = length $row->[ $i ];

            $width[ $i ] = $w if $w > $width[ $i ];
        }
    }

    print "$prefix\[\n";

    for my $row (@$matrix)
    {
        my @row_str;

        for my $i (0 .. $#$row)
        {
            push @row_str, sprintf '%*d', $width[ $i ], $row->[ $i ];
        }

        printf "%s  [%s]\n", $tab, join ', ', @row_str;
    }

    print "$tab]\n";
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

        my @rows     = split / \; /x, $matrix_str;
        my $matrix   = parse_matrix( \@rows );
        my $x_matrix = is_x_matrix( $matrix );

        is $x_matrix, $expected, $test_name;
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
Example 1|1 0 0 2;  0 3 4 0;  0 5 6 0;  7 0 0 1|1
Example 2|1 2 3  ;  4 5 6  ;  7 8 9            |0
Example 3|1 0 2  ;  0 3 0  ;  4 0 5            |1
