#!perl

###############################################################################
=comment

Perl Weekly Challenge 101
=========================

Task #1
-------
*Pack a Spiral*

Submitted by: Stuart Little

You are given an array @A of items (integers say, but they can be anything).

Your task is to pack that array into an MxN matrix spirally counterclockwise,
as tightly as possible.

    'Tightly' means the absolute value |M-N| of the difference has to be as
    small as possible.

Example 1:

 Input: @A = (1,2,3,4)

 Output:

     4 3
     1 2

 Since the given array is already a 1x4 matrix on its own, but that's not as
 tight as possible. Instead, you'd spiral it counterclockwise into

     4 3
     1 2

Example 2:

 Input: @A = (1..6)

 Output:

     6 5 4
     1 2 3

 or

     5 4
     6 3
     1 2

 Either will do as an answer, because they're equally tight.

Example 3:

 Input: @A = (1..12)

 Output:

        9  8  7 6
       10 11 12 5
        1  2  3 4

 or

        8  7 6
        9 12 5
       10 11 4
        1  2 3

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use enum           qw( RIGHT UP LEFT DOWN );
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 [<A> ...]

    [<A> ...]    A non-empty array of integers and/or integer ranges: I..J\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 101, Task #1: Pack a Spiral (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    # (1) Populate and validate the array

    my @A = get_array();

    printf "Input: \@A = (%s)\n", join ',', @A;

    # (2) Find M <= N such that M * N == @A.elems and |M - N| is a minimum

    my ($M, $N) = find_dimensions( \@A );

    # (3) Create and populate the M x N matrix

    my $matrix = pack_matrix( \@A, $M, $N );

    # (4) Print the matrix

    print "\nOutput:\n\n";

    print_matrix( $matrix );
}

#------------------------------------------------------------------------------
sub get_array
#------------------------------------------------------------------------------
{
    scalar @ARGV > 0 or error( 'Empty array' );

    my @A;

    for my $item (@ARGV)
    {
        if (my ($lhs, $rhs) = $item =~ / ^ (.+) \.\. (.+) $ /x)
        {
            for ($lhs, $rhs)
            {
                / ^ $RE{num}{int} $ /x
                     or error( qq[Item "$_" is not an integer] );
            }

            push @A, $lhs .. $rhs;
        }
        else
        {
            $item =~ / ^ $RE{num}{int} $ /x
                     or error( qq[Item "$item" is not an integer] );

            push @A, $item;
        }
    }

    return @A;
}

#------------------------------------------------------------------------------
sub find_dimensions
#------------------------------------------------------------------------------
{
    my ($A)     =  @_;
    my ($M, $N) = (1, scalar @$A);
    my  $root   =  int sqrt $N;

    if ($root * $root == $N)
    {
        ($M, $N) = ($root, $root);
    }
    else
    {
        for my $div1 (reverse 2 .. $root)
        {
            my $div2 = int($N / $div1);

            if ($div1 * $div2 == $N)
            {
                ($M, $N) = ($div1, $div2);
                last;
            }
        }
    }

    return $M, $N;
}

#------------------------------------------------------------------------------
sub pack_matrix
#------------------------------------------------------------------------------
{
    my ($A, $M, $N) =  @_;
    my  $max_row    =  $M - 1;
    my  $min_row    =  0;
    my  $max_col    =  $N - 1;
    my  $min_col    =  0;
    my  $row        =  $max_row;
    my  $col        = -1;
    my  $dir        =  RIGHT;
    my  @matrix;

    for my $item (@$A)
    {
        if    ($dir == RIGHT)
        {
            if (++$col > $max_col)
            {
                $col = $max_col;
                $dir = UP;
              --$row;
              --$max_row;
            }
        }
        elsif ($dir == UP)
        {
            if (--$row < $min_row)
            {
                $row = $min_row;
                $dir = LEFT;
              --$col;
              --$max_col;
            }
        }
        elsif ($dir == LEFT)
        {
            if (--$col < $min_col)
            {
                $col = $min_col;
                $dir = DOWN;
              ++$row;
              ++$min_row;
            }
        }
        else         # DOWN
        {
            if (++$row > $max_row)
            {
                $row = $max_row;
                $dir = RIGHT;
              ++$col;
              ++$min_col;
            }
        }

        $matrix[ $row ][ $col ] = $item;
    }

    return \@matrix;
}

#------------------------------------------------------------------------------
sub print_matrix
#------------------------------------------------------------------------------
{
    my ($matrix) = @_;
    my  $max_row = $#$matrix;
    my  $max_col = $#{ $matrix->[ 0 ] };
    my  @widths;

    # (1) Calculate maximum column widths

    for my $col (0 .. $max_col)
    {
        my $max = length $matrix->[ 0 ][ $col ];

        for my $row (1 .. $max_row)
        {
            my $len = length $matrix->[ $row ][ $col ];

            $max = $len if $len > $max;
        }

        push @widths, $max;
    }

    # (2) Print the matrix

    for my $row (0 .. $max_row)
    {
        print ' ' x 5;

        for my $col (0 .. $max_col)
        {
            printf " %*d", $widths[ $col ], $matrix->[ $row ][ $col ];
        }

        print "\n";
    }
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
