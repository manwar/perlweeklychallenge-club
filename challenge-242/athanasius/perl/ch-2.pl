#!perl

################################################################################
=comment

Perl Weekly Challenge 242
=========================

TASK #2
-------
*Flip Matrix*

Submitted by: Mohammad S Anwar

You are given n x n binary matrix.

Write a script to flip the given matrix as below.

  1 1 0
  0 1 1
  0 0 1

  a) Reverse each row

  0 1 1
  1 1 0
  1 0 0

  b) Invert each member

  1 0 0
  0 0 1
  0 1 1

Example 1

  Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
  Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])

Example 2

  Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
  Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])

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

use v5.32.1;          # Enables strictures
use warnings;
use Const::Fast;
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<matrix> ...]
  perl $0

    [<matrix> ...]    An n x n binary matrix, for example: 110 011 001\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 242, Task #2: Flip Matrix (Perl)\n\n";
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
        my $matrix  = parse_matrix( \@ARGV );

        printf "Input: \@matrix = (%s)\n",
            join ', ', map { '[' . join( ', ', @$_ ) . ']' } @$matrix;

        my $flipped = flip_matrix( $matrix );

        printf "Output:          (%s)\n",
            join ', ', map { '[' . join( ', ', @$_ ) . ']' } @$flipped;
    }
}

#-------------------------------------------------------------------------------
sub flip_matrix
#-------------------------------------------------------------------------------
{
    my ($matrix) = @_;
    my  @flipped = @$matrix;
    my  $end     = $#flipped;

    # a) Reverse each row

    for my $i (0 .. $end)
    {
        $flipped[ $i ] = [ reverse @{ $flipped[ $i ] } ];
    }

    # b) Invert each member

    for my $i (0 .. $end)
    {
        for my $j (0 .. $end)
        {
            $flipped[ $i ][ $j ] = $flipped[ $i ][ $j ] == 0 ? 1 : 0;
        }
    }

    return \@flipped;
}

#-------------------------------------------------------------------------------
sub parse_matrix
#-------------------------------------------------------------------------------
{
    my ($rows) = @_;
    my  $n     = scalar @$rows;
    my  @matrix;

    for my $row (@$rows)
    {
        length $row == $n or error( 'The input matrix is not square' );

        my @new_row = split //, $row;

        for (@new_row)
        {
            / ^ [01] $ /x or error( qq["$_" is not a binary number] );
        }

        push @matrix, [ @new_row ];
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

        my $matrix   = parse_matrix( [ split / \s+ /x, $matrix_str   ] );
        my $flipped  = flip_matrix( $matrix );
        my $expected = parse_matrix( [ split / \s+ /x, $expected_str ] );

        is_deeply $flipped, $expected, $test_name;
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
Example 0|110  011  001      |100  001  011
Example 1|110  101  000      |100  010  111
Example 2|1100 1001 0111 1010|1100 0110 0001 1010
