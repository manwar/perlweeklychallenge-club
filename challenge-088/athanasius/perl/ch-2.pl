#!perl

###############################################################################
=comment

Perl Weekly Challenge 088
=========================

Task #2
-------
*Spiral Matrix*

Submitted by: Mohammad S Anwar

You are given m x n matrix of positive integers.

Write a script to print spiral matrix as list.

Example 1:

 Input:
     [ 1, 2, 3 ]
     [ 4, 5, 6 ]
     [ 7, 8, 9 ]
 Output:
     [ 1, 2, 3, 6, 9, 8, 7, 4, 5 ]

Example 2:

 Input:
     [  1,  2,  3,  4 ]
     [  5,  6,  7,  8 ]
     [  9, 10, 11, 12 ]
     [ 13, 14, 15, 16 ]
 Output:
     [ 1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 6, 7, 11, 10 ]

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------

Two CLIs are provided:

1.  For an m x n matrix in which the elements are 1 to m * n in left-to-right,
    top-to-bottom order, the user may simply specify m and n explicitly; for
    example:

        perl ch-2.pl -m 4 -n 4

    produces the matrix in Example 2.

2.  For all other cases, the user must specify rows as whitespace-separated
    strings, each string being a comma-separated list of elements; for example:

        perl ch-2.pl  9,8,7  6,5,4  3,2,1

    produces the matrix in Example 1, but with elements in reverse order.

Algorithm
---------

1.  The outer elements of the matrix are read in clockwise order, beginning at
    the top left corner:
     - top row:      first to last columns
     - right column: second to last rows
     - bottom row:   second-last to first column
     - left column:  second-last to second row.

2.  A new, "inner" matrix is constructed by removing the outer rows and columns
    of the current matrix.

3.  Recursion: steps 1 and 2 above are applied to the new matrix. The recursion
    ends when:
     (1) the new matrix is a single row;    or
     (2) the new matrix is a single column; or
     (3) the new matrix is empty.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Getopt::Long;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 [<rows> ...]
  perl $0 [-m <Pos>] [-n <Pos>]

    [<rows> ...]    One or more same-width rows, each a comma-separated list of
one or more positive integers
    -m <Pos>        Positive integer: matrix height (total number of rows)
    -n <Pos>        Positive integer: matrix width (total number of columns)
";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 088, Task #2: Spiral Matrix (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $matrix = get_matrix();

    print "Input:\n";
    print_matrix( $matrix );

    my $spiral = find_spiral( $matrix );

    print "Output:\n";
    printf "    [ %s ]\n", join ' ', @$spiral;
}

#------------------------------------------------------------------------------
sub find_spiral                                          # Recursive subroutine
#------------------------------------------------------------------------------
{
    my ($matrix) = @_;
    my  $max_row = $#$matrix;
    my  $max_col = $#{ $matrix->[0] };
    my  @spiral;

    if    ($max_row == 0)                        # Base case (1): single row
    {
        push @spiral, @{ $matrix->[0] }[0 .. $max_col];
    }
    elsif ($max_col == 0)                        # Base case (2): single column
    {
        push @spiral, $matrix->[$_][0] for 0 .. $max_row;
    }
    else
    {
        # Step 1: Read the outer matrix elements in clockwise order, beginning
        #         at the top left corner

        my @top    =         0 .. $max_col;
        my @right  =         1 .. $max_row;
        my @bottom = reverse 0 .. $max_col - 1;
        my @left   = reverse 1 .. $max_row - 1;

        push @spiral, @{ $matrix->[0       ] }[@top    ];
        push @spiral,    $matrix->[$_      ]  [$max_col] for @right;
        push @spiral, @{ $matrix->[$max_row] }[@bottom ];
        push @spiral,    $matrix->[$_      ]  [0       ] for @left;

        # Step 2: Construct a new ("inner") matrix by removing the outer rows
        #         and columns

        my @new_matrix;

        for my $row (1 .. $max_row - 1)
        {
            push @new_matrix, [ @{ $matrix->[$row] }[1 .. $max_col - 1] ];
        }

        if ($#new_matrix >= 0 && $#{ $new_matrix[0] } >= 0)
        {
            # Step 3: Recurse on the inner matrix

            push @spiral, @{ find_spiral( \@new_matrix ) };
        }
      # else: Base case (3): the new matrix is empty
    }

    return \@spiral;
}

#------------------------------------------------------------------------------
sub get_matrix
#------------------------------------------------------------------------------
{
    scalar @ARGV > 0        or error( 'Missing input matrix' );

    my ($m, $n);

    GetOptions
    (
        "m:i" => \$m,
        "n:i" => \$n,
    )                       or error( 'Invalid command line argument(s)' );

    my $matrix;

    if (defined $m || defined $n)
    {
        scalar @ARGV == 0   or error( 'Extra command line argument(s) found' );

        $matrix = construct_matrix( $m, $n );
    }
    else
    {
        $matrix = read_matrix( @ARGV );
    }

    return $matrix;
}

#------------------------------------------------------------------------------
sub construct_matrix
#------------------------------------------------------------------------------
{
    my ($m, $n) = @_;

    defined $m                or error( 'Missing value for -m' );
    defined $n                or error( 'Missing value for -n' );

    $m =~ /\A$RE{num}{int}\z/ or error( "-m=$m is not an integer" );
    $m > 0                    or error( "-m=$m is not positive"   );

    $n =~ /\A$RE{num}{int}\z/ or error( "-n=$n is not an integer" );
    $n > 0                    or error( "-n=$n is not positive"   );

    my @matrix;
    my $element = 1;

    for my $row (0 .. $m - 1)
    {
        $matrix[$row] = [$element .. $element + $n - 1];

        $element += $n;
    }

    return \@matrix;
}

#------------------------------------------------------------------------------
sub read_matrix
#------------------------------------------------------------------------------
{
    my @rows = @_;
    my @matrix;
    my $width;

    for my $i (0 .. $#rows)
    {
        my $row  = $rows[$i];
        my @nums = split /,/, $row;

        if ($i == 0)
        {
            $width = scalar @nums;
        }
        else
        {
            scalar @nums == $width
                or error( sprintf 'Inconsistent number of columns in row %d',
                                   $i + 1 );
        }

        for (@nums)
        {
            /\A$RE{num}{int}\z/ or error( qq["$_" is not an integer] );
            $_ > 0              or error( qq["$_" is not positive]   );

            push @{ $matrix[$i] }, $_;
        }
    }

    return \@matrix;
}

#------------------------------------------------------------------------------
sub print_matrix
#------------------------------------------------------------------------------
{
    my ($matrix) = @_;

    # 1. Pre-compute the maximum width of each matrix column

    my @widths;

    for my $col (0 .. $#{ $matrix->[0] })
    {
        my $max_width = 0;

        for my $row (0 .. $#$matrix)
        {
            my $width  = length $matrix->[$row][$col];
            $max_width = $width if $width > $max_width;
        }

        $widths[$col] = $max_width;
    }

    # 2. Print the matrix

    for my $row (0 .. $#$matrix)
    {
        my @vals;

        for my $col (0 .. $#{ $matrix->[0] })
        {
            push @vals, sprintf '%*d', $widths[$col], $matrix->[$row][$col];
        }

        printf "    [ %s ]\n", join ' ', @vals;
    }

    print "\n";
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
