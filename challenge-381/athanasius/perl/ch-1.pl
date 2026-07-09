#!perl

################################################################################
=comment

Perl Weekly Challenge 381
=========================

TASK #1
-------
*Same Row Column*

Submitted by: Mohammad Sajid Anwar

You are given a n x n matrix containing integers from 1 to n.

Write a script to find if every row and every column contains all the integers
from 1 to n.

Example 1

  Input: @matrix = ([1, 2, 3, 4],
                    [2, 3, 4, 1],
                    [3, 4, 1, 2],
                    [4, 1, 2, 3],)
  Output: true

Example 2

  Input: @matrix = ([1])
  Output: true

Example 3

  Input: @matrix = ([1, 2, 5],
                    [5, 1, 2],
                    [2, 5, 1],)
  Output: false

  Elements are out of range 1..3.

Example 4

  Input: @matrix = ([1, 2, 3],
                    [1, 2, 3],
                    [1, 2, 3],)
  Output: false

Example 5

  Input: @matrix = ([1, 2, 3],
                    [3, 1, 2],
                    [3, 2, 1],)
  Output: false

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input matrix is entered on the command-line as a non-empty list of
   strings (the matrix rows) containing elements separated by whitespace. For
   example, the matrix:

        ⎡1 2 3 4⎤
        ⎢2 3 4 1⎥
        ⎢3 4 1 2⎥
        ⎣4 1 2 3⎦

   is entered as: >perl ch-1.pl "1 2 3 4" "2 3 4 1" "3 4 1 2" "4 1 2 3"

Note
----
Matrix-handling code is adapted from the solution to Task 2 for Week 266.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use boolean;
use open           qw{ :std :encoding(UTF-8) };
use utf8;
use warnings;
use Array::Compare;
use Const::Fast;
use Regexp::Common qw{ number };
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
    print "\nChallenge 381, Task #1: Same Row Column (Perl)\n\n";
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

        my $same = same_row_col( $matrix );

        printf "Output: %s\n", $same ? 'true' : 'false';
    }
}

#-------------------------------------------------------------------------------
sub same_row_col
#-------------------------------------------------------------------------------
{
    my ($matrix) = @_;

    for my $row (0 .. $#$matrix)
    {
        return false unless is_full( $matrix->[ $row ] );

        my @column;

        for my $col (0 .. $#$matrix)
        {
            push @column, $matrix->[ $col ][ $row ];
        }

        return false unless is_full( \@column );
    }

    return true;
}

#-------------------------------------------------------------------------------
sub is_full
#-------------------------------------------------------------------------------
{
    my ($list)  = @_;
    my  @target = 1 .. scalar @$list;
    my  @sorted = sort { $a <=> $b } @$list;
    my  $comp   = Array::Compare->new;

    return $comp->compare( \@target, \@sorted );
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

    if (scalar @$matrix == 1)
    {
        printf "$prefix\[%d]\n", $matrix->[ 0 ][ 0 ];
    }
    else
    {
        my $tab   = ' ' x length $prefix;
        my @width = (1) x scalar $matrix->[ 0 ]->@*;

        for my $row (@$matrix)
        {
            for my $i (0 .. $#$row)
            {
                my $w        = length $row->[ $i ];
                $width[ $i ] = $w if $w > $width[ $i ];
            }
        }

        printf "%s⎡%s⎤\n", $prefix, format_row( \@width, $matrix->[ 0  ] );

        printf "%s⎢%s⎥\n", $tab,    format_row( \@width, $matrix->[ $_ ] )
            for 1 .. $#$matrix - 1;

        printf "%s⎣%s⎦\n", $tab,    format_row( \@width, $matrix->[ -1 ] );
    }
}

#-------------------------------------------------------------------------------
sub format_row
#-------------------------------------------------------------------------------
{
    my ($width, $row) = @_;
    my  @row_str;

    for my $i (0 .. $#$row)
    {
        push @row_str, sprintf '%*d', $width->[ $i ], $row->[ $i ];
    }

    return join ' ', @row_str;
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

        my @rows   = split / ; /x, $matrix_str;
        my $matrix = parse_matrix( \@rows );
        my $same   = same_row_col( $matrix ) ? 'true' : 'false';

        is $same, $expected, $test_name;
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
Example 1|1 2 3 4; 2 3 4 1; 3 4 1 2; 4 1 2 3|true
Example 2|1                                 |true
Example 3|1 2 5;   5 1 2;   2 5 1           |false
Example 4|1 2 3;   1 2 3;   1 2 3           |false
Example 5|1 2 3;   3 1 2;   3 2 1           |false
