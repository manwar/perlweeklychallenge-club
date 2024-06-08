#!perl

################################################################################
=comment

Perl Weekly Challenge 271
=========================

TASK #1
-------
*Maximum Ones*

Submitted by: Mohammad Sajid Anwar

You are given a m x n binary matrix.

Write a script to return the row number containing maximum ones, in case of more
than one rows then return smallest row number.

Example 1

  Input: $matrix = [ [0, 1],
                     [1, 0],
                   ]
  Output: 1

  Row 1 and Row 2 have the same number of ones, so return row 1.

Example 2

  Input: $matrix = [ [0, 0, 0],
                     [1, 0, 1],
                   ]
  Output: 2

  Row 2 has the maximum ones, so return row 2.

Example 3

  Input: $matrix = [ [0, 0],
                     [1, 1],
                     [0, 0],
                   ]
  Output: 2

  Row 2 have the maximum ones, so return row 2.

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
2. The matrix is entered on the command-line as a series of non-empty, same-
   length bit-strings, one for each matrix row.

Reference
---------
Code for handling binary matrices adapted from the Perl solution to Week 270,
Task #1, "Special Positions".

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE => <<END;
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
    print "\nChallenge 271, Task #1: Maximum Ones (Perl)\n\n";
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

        printf "Input:  \$matrix = [%s]\n",    join ' ', $matrix->[ 0    ]->@*;

        for my $row (1 .. $#$matrix)
        {
            printf "                  [%s]\n", join ' ', $matrix->[ $row ]->@*;
        }

        my $row = find_max_row( $matrix );

        print "Output: $row\n";
    }
}

#-------------------------------------------------------------------------------
sub find_max_row
#-------------------------------------------------------------------------------
{
    my ($matrix)   = @_;
    my  $max_count = 0;
    my  $max_row   = 0;

    for my $row (0 .. $#$matrix)
    {
        my $count  = 0;
           $count += $_ for $matrix->[ $row ]->@*;

        if ($count > $max_count)
        {
            $max_count = $count;
            $max_row   = $row;
        }
    }

    return $max_row + 1;                    # Change from 0- to 1-based indexing
}

#-------------------------------------------------------------------------------
sub parse_matrix
#-------------------------------------------------------------------------------
{
    my  ($rows) = @_;
    my   $n     = length $rows->[ 0 ];
    my   @matrix;

    for (@$rows)
    {
        / ^ [01]+ $ /x or error( qq["$_" is not a valid bitstring] );

        length == $n   or error( 'The input matrix is not rectangular' );

        push @matrix, [ split // ];
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

        my  ($test_name, $matrix_str, $expected) = split / \| /x, $line;

        for ($test_name, $matrix_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @rows   = split / \s+ /x, $matrix_str;
        my $matrix = parse_matrix( \@rows );
        my $row    = find_max_row( $matrix );

        is $row, $expected, $test_name;
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
Example 1|01    10                     |1
Example 2|000   101                    |2
Example 3|00    11    00               |2
Singleton|0                            |1
1st of 2 |00000 11011 00100 10111 00000|2
Last     |0000  0100  1010  1011  1111 |5
