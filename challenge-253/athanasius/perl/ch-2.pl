#!perl

################################################################################
=comment

Perl Weekly Challenge 253
=========================

TASK #2
-------
*Weakest Row*

Submitted by: Mohammad S Anwar

You are given an m x n binary matrix i.e. only 0 and 1 where 1 always appear
before 0.

A row i is weaker than a row j if one of the following is true:

  a) The number of 1s in row i is less than the number of 1s in row j.
  b) Both rows have the same number of 1 and i < j.

Write a script to return the order of rows from weakest to strongest.

Example 1

  Input: $matrix = [
                     [1, 1, 0, 0, 0],
                     [1, 1, 1, 1, 0],
                     [1, 0, 0, 0, 0],
                     [1, 1, 0, 0, 0],
                     [1, 1, 1, 1, 1]
                   ]
  Output: (2, 0, 3, 1, 4)

  The number of 1s in each row is:
  - Row 0: 2
  - Row 1: 4
  - Row 2: 1
  - Row 3: 2
  - Row 4: 5

Example 2

  Input: $matrix = [
                     [1, 0, 0, 0],
                     [1, 1, 1, 1],
                     [1, 0, 0, 0],
                     [1, 0, 0, 0]
                   ]
  Output: (0, 2, 3, 1)

  The number of 1s in each row is:
  - Row 0: 1
  - Row 1: 4
  - Row 2: 1
  - Row 3: 1

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

    [<matrix> ...]    Non-empty binary matrix in which each row begins with 1
                      e.g., 11000 11110 10000 11000 11111

END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 253, Task #2: Weakest Row (Perl)\n\n";
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

        my $ranked = rank_rows( $matrix );

        printf "Output: (%s)\n", join ', ', @$ranked;
    }
}

#-------------------------------------------------------------------------------
sub rank_rows
#-------------------------------------------------------------------------------
{
    my ($matrix) = @_;
    my  @ranked  = sort
        {
            count_ones( $matrix->[ $a ] ) <=> count_ones( $matrix->[ $b ] )
                                          ||
                                       $a <=> $b
        } 0 .. $#$matrix;

    return \@ranked;
}

#-------------------------------------------------------------------------------
sub count_ones
#-------------------------------------------------------------------------------
{
    my ($row)   = @_;
    my  $count  = 0;
        $count += $_ for @$row;

    return $count;
}

#-------------------------------------------------------------------------------
sub parse_matrix
#-------------------------------------------------------------------------------
{
    my ($matrix_strs) = @_;
    my  @matrix;
    my  $num_cols;
    
    for my $row (@$matrix_strs)
    {
        $row =~ / ^ 1 [01]* $ /x
                or error( qq["$row" is not a valid row] );

        my @row = split '', $row;

        if (defined $num_cols)
        {
            scalar @row == $num_cols
                or error( 'The input matrix is not rectangular' );
        }
        else
        {
            $num_cols = scalar @row;
        }

        push @matrix, \@row;
    }

    return \@matrix;
}

#-------------------------------------------------------------------------------
sub print_matrix
#-------------------------------------------------------------------------------
{
    my ($prefix, $matrix) = @_;
    my  $tab = ' ' x length $prefix;

    print "$prefix\[ ";

    for my $i (0 .. $#$matrix)
    {
        my $row = $matrix->[ $i ];

        printf '%s[%s]', $i == 0 ? '' : "$tab  ", join ', ', @$row;

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

        my  ($test_name, $matrix_strs, $expected_str) = split / \| /x, $line;

        for ($test_name, $matrix_strs, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @rows     = split / \s+ /x, $matrix_strs;
        my $matrix   = parse_matrix( \@rows );
        my $ranked   = rank_rows( $matrix );
        my @expected = split / \s+ /x, $expected_str;

        is_deeply $ranked, \@expected, $test_name;
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
Example 1|11000 11110 10000 11000 11111|2 0 3 1 4
Example 2|1000  1111  1000  1000       |0 2 3 1
Singleton|1                            |0
