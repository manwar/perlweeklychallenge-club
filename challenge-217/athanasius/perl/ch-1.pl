#!perl

################################################################################
=comment

Perl Weekly Challenge 217
=========================

TASK #1
-------
*Sorted Matrix*

Submitted by: Mohammad S Anwar

You are given a n x n matrix where n >= 2.

Write a script to find 3rd smallest element in the sorted matrix.

Example 1

  Input: @matrix = ([3, 1, 2], [5, 2, 4], [0, 1, 3])
  Output: 1

  The sorted list of the given matrix: 0, 1, 1, 2, 2, 3, 3, 4, 5.
  The 3rd smallest of the sorted list is 1.

Example 2

  Input: @matrix = ([2, 1], [4, 5])
  Output: 4

  The sorted list of the given matrix: 1, 2, 4, 5.
  The 3rd smallest of the sorted list is 4.

Example 3

  Input: @matrix = ([1, 0, 3], [0, 0, 0], [1, 2, 1])
  Output: 0

  The sorted list of the given matrix: 0, 0, 0, 0, 1, 1, 1, 2, 3.
  The 3rd smallest of the sorted list is 0.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value (the default), the output is followed by
   an explanation of the result.

Assumption
----------
Matrix elements are integers.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 <matrix>
  perl $0

    <matrix>    String representation of an n x n integer matrix where n >= 2
";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 217, Task #1: Sorted Matrix (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args == 1)
    {
        my $matrix = parse_matrix_string( $ARGV[ 0 ] );

        printf "Input:  \@matrix = %s\n", format_matrix( $matrix );

        my @elements;
        my $third_smallest = find_third_smallest( $matrix, \@elements );

        printf "Output: %d\n", $third_smallest;

        if ($VERBOSE)
        {
            printf "\nThe sorted list of the given matrix: %s\n",
                    join ', ', @elements;

            my $padding = length( $elements[ 0 ] ) +
                          length( $elements[ 1 ] ) + 4;

            printf "The third-smallest element:          %s%s\n",
                   ' ' x $padding, '^' x length $third_smallest;
        }
    }
    else
    {
        error( "Expected 0 or 1 command-line arguments, found $args" );
    }
}

#-------------------------------------------------------------------------------
sub find_third_smallest
#-------------------------------------------------------------------------------
{
    my ($matrix, $elements_ref) = @_;
    my  @elements;

    push @elements, @$_ for @$matrix;

    @elements = sort { $a <=> $b } @elements;

    scalar @elements >= 3 or error( 'Matrix too small' );

    @$elements_ref = @elements if $elements_ref;

    return $elements[ 2 ];
}

#-------------------------------------------------------------------------------
sub parse_matrix_string
#-------------------------------------------------------------------------------
{
    my ($matrix) = @_;

    $matrix =~ / ^ \s* \( (.*?) \s* \) \s* $ /x
        or error( 'Invalid input string' );

    my $body = $1;
    my @matrix;

    while ($body =~ / \[ (.+?) \] /gx)
    {
        my $row = $1;
        my @elems = split / , \s* /x, $row;

        for my $elem (@elems)
        {
            $elem =~ s/ ^ \s+   //x;
            $elem =~ s/   \s+ $ //x;
            $elem =~ m/ ^ $RE{num}{int} $ /x
                or error( qq["$elem" is not a valid integer] );
        }

        push @matrix, [ @elems ];
    
    }

    validate_matrix( \@matrix );

    return \@matrix;
}

#-------------------------------------------------------------------------------
sub validate_matrix
#-------------------------------------------------------------------------------
{
    my ($matrix) = @_;

    my $rows = scalar @$matrix;
    my $n    = scalar @{ $matrix->[ 0 ] };

    $rows >=  2 or error( 'Too few rows in matrix' );
    $rows == $n or error( 'Matrix is not square'   );

    for my $i (1 .. $#$matrix)
    {
        my $m = scalar @{ $matrix->[ $i ] };
        my $j = $i + 1;

        $m == $n or error( "In matrix row $j: expected $n elements, found $m" );
    }
}

#-------------------------------------------------------------------------------
sub format_matrix
#-------------------------------------------------------------------------------
{
    my ($matrix)    = @_;
    my  $matrix_str = '(';
    my  @row_strs;

    for my $elems (@$matrix)
    {
        push @row_strs, '[' . join( ', ', @$elems ) . ']';
    }

    $matrix_str .= join( ', ', @row_strs ) . ')';

    return $matrix_str;
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

        for ($test_name, $matrix_str, $expected)               # Trim whitespace
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @matrix         = parse_matrix_string( $matrix_str );
        my $third_smallest = find_third_smallest( @matrix );

        is $third_smallest, $expected, $test_name;
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
Example 1|([3,  1,  2], [5,  2,  4], [ 0, 1, 3])| 1
Example 2|([2,  1],     [4,  5])                | 4
Example 3|([1,  0,  3], [0,  0,  0], [ 1, 2, 1])| 0
Negatives|([0, -1, -2], [0, -1, -3], [-3, 1, 2])|-2
