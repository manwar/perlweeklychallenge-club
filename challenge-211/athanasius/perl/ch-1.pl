#!perl

################################################################################
=comment

Perl Weekly Challenge 211
=========================

TASK #1
-------
*Toeplitz Matrix*

Submitted by: Mohammad S Anwar

You are given a matrix m x n.

Write a script to find out if the given matrix is Toeplitz Matrix.

    A matrix is Toeplitz if every diagonal from top-left to bottom-right has the
    same elements.

Example 1

  Input: @matrix = [ [4, 3, 2, 1],
                     [5, 4, 3, 2],
                     [6, 5, 4, 3],
                   ]
  Output: true

Example 2

  Input: @matrix = [ [1, 2, 3],
                     [3, 2, 1],
                   ]
  Output: false

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

use strict;
use warnings;
use Const::Fast;
use Data::Dump qw( pp );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 <matrix>
  perl $0

    <matrix>    String representing a matrix\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 211, Task #1: Toeplitz Matrix (Perl)\n\n";
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

        printf "Input:  \@matrix = %s\n", pp( $matrix );

        printf "Output: %s\n", is_toeplitz_matrix( $matrix ) ? 'True' : 'False';
    }
    else
    {
        error( "Expected 1 or 0 command line arguments, found $args");
    }
}

#-------------------------------------------------------------------------------
sub is_toeplitz_matrix
#-------------------------------------------------------------------------------
{
    my ($matrix) = @_;
    my  $rows    = scalar @$matrix;
    my  $cols    = scalar  $matrix->[ 0 ]->@*;

    for my $row (0 .. $rows - 2)
    {
        for my $col (0 .. $cols - 2)
        {
            return 0 unless $matrix->[ $row     ][ $col     ] eq
                            $matrix->[ $row + 1 ][ $col + 1 ];
        }
    }

    return 1;
}

#-------------------------------------------------------------------------------
sub parse_matrix_string
#-------------------------------------------------------------------------------
{
    my ($string) = @_;

    $string =~ / ^ \s* \[ \s* (.+) \] \s* $ /x
        or error( 'Malformed matrix string' );

    $string = $1;

    $string =~ / ^ \[ .+ \] $ /x
        or error( 'Malformed matrix string' );

    my @matrix;

    while ($string =~ / \G \,? \s* \[ \s* (.+?) \] /gx)
    {
        push @matrix, [ split / , \s* /x, $1 ];
    }

    scalar @matrix > 0
        or error( 'Empty matrix' );

    my $cols = scalar $matrix[ 0 ]->@*;

    for my $row (1 .. $#matrix)
    {
        scalar( $matrix[ $row ]->@* ) == $cols
            or error( 'Ragged array' );
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

        my ($test_name, $input, $expected) = split / \| /x, $line;

        $test_name =~ s/ \s+ $ //x;              # Trim whitespace
        $input     =~ s/ \s+ $ //x;

        my $matrix = parse_matrix_string( $input );
        my $got    = is_toeplitz_matrix( $matrix ) ? 'True' : 'False';

        is $got, $expected, $test_name;
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
Example 1     |[[4,3,2,1],[5,4,3,2],[6,5,4,3]]      |True
Example 2     |[[1,2,3],[3,2,1]]                    |False
Single element|[[42]]                               |True
Single row    |[[17,-3,12,9,5,0,7]]                 |True
Single column |[[apple][banana][guava][pear]]       |True
Alternating   |[[0,1,0,1,0],[1,0,1,0,1],[0,1,0,1,0]]|True
Deceptive 1   |[[0,1,0,1,0],[1,0,1,0,1],[0,1,O,1,0]]|False
Deceptive 2   |[[O,1,0,1,0],[1,O,1,0,1],[0,1,O,1,0]]|True
