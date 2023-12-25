#!perl

################################################################################
=comment

Perl Weekly Challenge 248
=========================

TASK #2
-------
*Submatrix Sum*

Submitted by: Jorg Sommrey

You are given a NxM matrix A of integers.

Write a script to construct a (N-1)x(M-1) matrix B having elements that are the
sum over the 2x2 submatrices of A,

  b[i,k] = a[i,k] + a[i,k+1] + a[i+1,k] + a[i+1,k+1]

Example 1

  Input: $a = [
                [1,  2,  3,  4],
                [5,  6,  7,  8],
                [9, 10, 11, 12]
              ]

  Output: $b = [
                 [14, 18, 22],
                 [30, 34, 38]
               ]

Example 2

  Input: $a = [
                [1, 0, 0, 0],
                [0, 1, 0, 0],
                [0, 0, 1, 0],
                [0, 0, 0, 1]
              ]

  Output: $b = [
                 [2, 1, 0],
                 [1, 2, 1],
                 [0, 1, 2]
               ]

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
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
use Regexp::Common qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<a> ...]
  perl $0

    [<a> ...]    An N x M matrix of integers (N, M >= 2)\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 248, Task #2: Submatrix Sum (Perl)\n\n";
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
        my $matrix_a = parse_matrix( \@ARGV );

        print_matrix( 'Input:  $a = ', $matrix_a );

        my $matrix_b = submatrix_sum(  $matrix_a );

        print "\n";
        print_matrix( 'Output: $b = ', $matrix_b );
    }
}

#-------------------------------------------------------------------------------
sub submatrix_sum
#-------------------------------------------------------------------------------
{
    my ($matrix_a) = @_;
    my  @matrix_b;

    for my $i (0 .. $#$matrix_a - 1)
    {
        for my $k (0 .. $#{ $matrix_a->[ 0 ] } - 1)
        {
            # b[i,k] = a[i,k] + a[i,k+1] + a[i+1,k] + a[i+1,k+1]

            $matrix_b[ $i ][ $k ] = $matrix_a->[ $i     ][ $k     ] +
                                    $matrix_a->[ $i     ][ $k + 1 ] +
                                    $matrix_a->[ $i + 1 ][ $k     ] +
                                    $matrix_a->[ $i + 1 ][ $k + 1 ];
        }
    }

    return \@matrix_b;
}

#-------------------------------------------------------------------------------
sub parse_matrix
#-------------------------------------------------------------------------------
{
    my ($a) = @_;
    my (@matrix, $num_cols);

    for my $row_str (@$a)
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

        push @matrix, \@row;

        if (defined $num_cols)
        {
            scalar @row == $num_cols
                or error( 'The input matrix is not rectangular' );
        }
        else
        {
            $num_cols  = scalar @row;
            $num_cols >= 2 or error( 'M is too small' );
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

        my  ($test_name, $matrix_str, $expected_str) = split / \| /x, $line;

        for ($test_name, $matrix_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @a = split / \; /x, $matrix_str;
        my @b = split / \; /x, $expected_str;

        my $matrix_a = parse_matrix( \@a );
        my $expected = parse_matrix( \@b );
        my $matrix_b = submatrix_sum( $matrix_a );

        is_deeply $matrix_b, $expected, $test_name;
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
Example 1|1 2 3 4; 5 6 7 8; 9 10 11 12|14 18 22; 30 34 38
Example 2|1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1|2 1 0; 1 2 1; 0 1 2
