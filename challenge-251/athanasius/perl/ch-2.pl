#!perl

################################################################################
=comment

Perl Weekly Challenge 251
=========================

TASK #2
-------
*Lucky Numbers*

Submitted by: Mohammad S Anwar

You are given a m x n matrix of distinct numbers.

Write a script to return the lucky number, if there is one, or -1 if not.

  A lucky number is an element of the matrix such that it is
  the minimum element in its row and maximum in its column.

Example 1

  Input: $matrix = [ [ 3,  7,  8],
                     [ 9, 11, 13],
                     [15, 16, 17] ];
  Output: 15

  15 is the only lucky number since it is the minimum in its row
  and the maximum in its column.

Example 2

  Input: $matrix = [ [ 1, 10,  4,  2],
                     [ 9,  3,  8,  7],
                     [15, 16, 17, 12] ];
  Output: 12

Example 3

  Input: $matrix = [ [7, 8],
                     [1, 2] ];
  Output: 7

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Assumptions
-----------
Since -1 is returned on failure, elements of the input matrix are limited to
non-negative numbers. For convenience, they are in addition limited to integers.

Algorithm
---------
This is a simple search for a lucky number: if one is found, it is immediately
returned, otherwise after the search has completed -1 is returned.

In fact, there can only ever be one lucky number for a given matrix. Proof (by
contradiction):

1. Let element x = matrix(i, j) be a lucky number. Can there be another lucky
   number in the same matrix?

2. Assume there is a lucky number y = matrix(k, l) with k ≠ i and l ≠ j.

3. Let w = matrix(i, l). Since x is the smallest element in row i, w > x.
   And since y is the largest element in column l, y > w. So, y > w > x, and by
   transitivity, y > x (a).

4. Let z = matrix(k, j). Since x is the largest element in column j, z < x.
   And since y is the smallest element in row k, y < z. So, y < z < x, and by
   transitivity, y < x (b).

5. Relations (a) and (b) are mutually contradictory, therefore the assumption
   made in step 2 must be false. QED.

Note
----
This solution incorporates or adapts code used in the solution of Task 2 for
Challenge 248.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use List::Util     qw( min );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<matrix> ...]
  perl $0

    [<matrix> ...]    A non-empty matrix of distinct unsigned integers
                      e.g., "3 7 8" "9 11 13" "15 16 17"
                      Note: the input matrix must be rectangular
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 251, Task #2: Lucky Numbers (Perl)\n\n";
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

        printf "Output: %d\n", find_lucky_number( $matrix );
    }
}

#-------------------------------------------------------------------------------
sub find_lucky_number
#-------------------------------------------------------------------------------
{
    my ($matrix) = @_;

    for my $row (@$matrix)
    {
        my $row_min = min @$row;                           # Row minimum

        for my $col (0 .. $#$row)
        {
            if ($row->[ $col ] == $row_min)
            {
                my $col_max = 0;

                for my $row (0 .. $#$matrix)               # Find column maximum
                {
                    my $elem = $matrix->[ $row ][ $col ];

                    $col_max = $elem if $elem > $col_max;
                }

                return $row_min if $row_min == $col_max;
            }
        }
    }

    return -1;
}

#-------------------------------------------------------------------------------
sub parse_matrix
#-------------------------------------------------------------------------------
{
    my ($matrix_strs) = @_;
    my  @matrix;
    my  %dict;
    my  $num_cols;

    for my $row_str (@$matrix_strs)
    {
        my $row = fill_row( $row_str, \%dict );

        push @matrix, $row;

        if (defined $num_cols)
        {
            scalar @$row == $num_cols
                or error( 'The matrix is not rectangular' );
        }
        else
        {
            ($num_cols = scalar @$row) > 0
                or error( 'The first row is empty' );
        }
    }

    return \@matrix;
}

#-------------------------------------------------------------------------------
sub fill_row
#-------------------------------------------------------------------------------
{
    my ($row_str, $dict) = @_;
    my  @row;

    for my $elem_str (split ' ', $row_str)        # split ' ' removes leading ws
    {
        $elem_str =~ / ^ $RE{num}{int} $ /x
            or error( qq["$elem_str" is not a valid integer] );

        my $elem = $elem_str + 0;                 # Normalize

        $elem >= 0
            or error( qq["$elem" is negative] );

        ++$dict->{ $elem } == 1
            or error( qq[Element "$elem" is repeated] );

        push @row, $elem;
    }

    return \@row;
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

    print "$prefix\[ ";

    for my $i (0 .. $#$matrix)
    {
        my $row = $matrix->[ $i ];
        my @row_str;

        for my $j (0 .. $#$row)
        {
            push @row_str, sprintf '%*d', $width[ $j ], $row->[ $j ];
        }

        printf "%s\[%s]",  $i == 0 ? '' : $tab . '  ', join ', ', @row_str;
        print  "\n" unless $i == $#$matrix;
    }

    print " ]\n";
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

        my @rows      = split / \; /x, $matrix_str;
        my $matrix    = parse_matrix( \@rows );
        my $lucky_num = find_lucky_number( $matrix );

        is $lucky_num, $expected, $test_name;
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
Example 1|   3 7 8;   9 11 13;    15 16 17|15
Example 2|1 10 4 2; 9 3  8  7; 15 16 17 12|12
Example 3|     7 8;      1  2;            | 7
Singleton|       4;                       | 4
None     |     1 3;      4  2;            |-1
