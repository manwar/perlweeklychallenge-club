#!perl

###############################################################################
=comment

Perl Weekly Challenge 087
=========================

Task #2
-------
*Largest Rectangle*

Submitted by: Mohammad S Anwar

You are given matrix m x n with 0 and 1.

Write a script to find the largest rectangle containing only 1. Print 0 if none
found.

Example 1:

 Input:
     [ 0 0 0 1 0 0 ]
     [ 1 1 1 0 0 0 ]
     [ 0 0 1 0 0 1 ]
     [ 1 1 1 1 1 0 ]
     [ 1 1 1 1 1 0 ]

 Output:
     [ 1 1 1 1 1 ]
     [ 1 1 1 1 1 ]

Example 2:

 Input:
     [ 1 0 1 0 1 0 ]
     [ 0 1 0 1 0 1 ]
     [ 1 0 1 0 1 0 ]
     [ 0 1 0 1 0 1 ]

 Output: 0

Example 3:

 Input:
     [ 0 0 0 1 1 1 ]
     [ 1 1 1 1 1 1 ]
     [ 0 0 1 0 0 1 ]
     [ 0 0 1 1 1 1 ]
     [ 0 0 1 1 1 1 ]

 Output:
     [ 1 1 1 1 ]
     [ 1 1 1 1 ]

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

From Example 2, it is clear that the unit square [ 1 ] is not counted as a
"rectangle". But squares in general are rectangles, so the obvious conclusion
is that for the purposes of this Task an m x n rectangle must have m > 1 and
n > 1. Nevertheless, the constant $MIN_DIM is provided to allow different
constraints on the minimum dimensions of any candidate rectangle.

The algorithm is an exhaustive search, beginning with each "1" element in the
matrix which could (given the value of $MIN_DIM) be the upper, left-hand corner
of a candidate rectangle. For each such element, two searches are conducted:
one to the right, the other down. For example, given the following matrix:

 [ 0 1 1 1 0 0 ]
 [ 1 1 1 1 0 1 ]
 [ 0 1 1 0 0 0 ]
 [ 0 1 1 0 0 0 ]

a right-search beginning from the element at (0, 1) yields the rectangle:

 [ 1 1 1 ]
 [ 1 1 1 ] (area 6),

then a down-search beginning from the same element yields the larger rectangle:

 [ 1 1 ]
 [ 1 1 ]
 [ 1 1 ]
 [ 1 1 ] (area 8).

Note that if more than one solution would yield a rectangle of the same maximum
area, only the first will be output.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;

# The default value of $MIN-DIM is 2, ensuring that a rectangle has 4 distinct
# corners within the matrix. Set $MIN-DIM to 1 if single-width rectangles are
# to be allowed, e.g. [ 1 1 1 ]; but note that the unit square [ 1 ] will still
# be excluded.

const my $MIN_DIM => 2;

const my $USAGE =>
qq{Usage:
  perl $0 [<rows> ...]

    [<rows> ...]    1+ same-width rows, each a string of 1+ "1" & "0" chars\n};

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 087, Task #2: Largest Rectangle (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $matrix = get_matrix();

    print_matrix($matrix);

    my ($rows, $cols) = find_max_rectangle($matrix);

    if ($rows >= $MIN_DIM &&
        $cols >= $MIN_DIM && ($rows > 1 || $cols > 1))
    {
        print_rectangle($rows, $cols);
    }
    else
    {
        print "Output: 0\n";
    }
}

#------------------------------------------------------------------------------
sub find_max_rectangle
#------------------------------------------------------------------------------
{
    my ($matrix)    = @_;
    my  $max_row    = scalar @$matrix          - $MIN_DIM;
    my  $max_col    = scalar @{ $matrix->[0] } - $MIN_DIM;
    my  $max_area   = 0;
    my  $max_height = 0;
    my  $max_width  = 0;

    for my $row (0 .. $max_row)
    {
        for my $col (0 .. $max_col)
        {
            if ($matrix->[$row][$col] eq '1')
            {
                for my $func (\&find_max_rect_right, \&find_max_rect_down)
                {
                    my ($height, $width) = $func->($row, $col, $matrix);

                    if ((my $area = $height * $width) > $max_area)
                    {
                        $max_area   = $area;
                        $max_height = $height;
                        $max_width  = $width;
                    }
                }
            }
        }
    }

    return ($max_height, $max_width)
}

#------------------------------------------------------------------------------
sub find_max_rect_right
#------------------------------------------------------------------------------
{
    my ($corner_row, $corner_col, $matrix) = @_;

    my  $max_row = scalar @$matrix          - 1;
    my  $max_col = scalar @{ $matrix->[0] } - 1;
    my  $width   = 1;

    for my $c ($corner_col + 1 .. $max_col)
    {
        if ($matrix->[$corner_row][$c] eq '1')
        {
            ++$width;
        }
        else
        {
            last;
        }
    }

    my $height = 1;

    ROW:
    for my $r ($corner_row + 1 .. $max_row)
    {
        for my $c ($corner_col .. $corner_col + $width - 1)
        {
            last ROW unless $matrix->[$r][$c] eq '1';
        }

        ++$height;
    }

    return ($height, $width);
}
    
#------------------------------------------------------------------------------
sub find_max_rect_down
#------------------------------------------------------------------------------
{
    my ($corner_row, $corner_col, $matrix) = @_;

    my  $max_row = scalar @{ $matrix      } - 1;
    my  $max_col = scalar @{ $matrix->[0] } - 1;
    my  $height  = 1;

    for my $r ($corner_row + 1 .. $max_row)
    {
        if ($matrix->[$r][$corner_col] eq '1')
        {
            ++$height;
        }
        else
        {
            last;
        }
    }

    my $width = 1;

    COLUMN:
    for my $c ($corner_col + 1 .. $max_col)
    {
        for my $r ($corner_row .. $corner_row + $height - 1)
        {
            last COLUMN unless $matrix->[$r][$c] eq '1';
        }

        ++$width;
    }

    return ($height, $width);
}

#------------------------------------------------------------------------------
sub get_matrix
#------------------------------------------------------------------------------
{
    scalar @ARGV > 0
            or  error('Missing input matrix');

    my @rows  = @ARGV;
    my $width = length $rows[0];
    my @matrix;

    for my $i (0 .. $#rows)
    {
        my $row = $rows[$i];

        $row =~ / ( [^10] ) /x
            and error(qq[Invalid character "$1" in the input matrix]);

        length $row == $width
            or  error('Inconsistent number of columns in row ' . ($i + 1));

        push $matrix[$i]->@*, split(//, $row);
    }

    return \@matrix;
}

#------------------------------------------------------------------------------
sub print_matrix
#------------------------------------------------------------------------------
{
    my ($matrix) = @_;

    print "Input:\n";

    for my $i (0 .. $#$matrix)
    {
        printf "    [ %s ]\n", join ' ', $matrix->[$i]->@*;
    }

    print "\n";
}

#------------------------------------------------------------------------------
sub print_rectangle
#------------------------------------------------------------------------------
{
    my ($rows, $cols) = @_;

    print "Output:\n";

    for (1 .. $rows)
    {
        print '    [ ';
        print '1 ' for 1 .. $cols;
        print "]\n";
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
