#!perl

################################################################################
=comment

Perl Weekly Challenge 075
=========================

Task #2
-------
*Largest Rectangle Histogram*

Submitted by: Mohammad S Anwar

You are given an array of positive numbers _@A_.

Write a script to find the large[s]t rectangle histogram created by the given
array.

BONUS: Try to print the histogram as shown in the example, if possible.

Example 1:

Input: @A = (2, 1, 4, 5, 3, 7)

     7           #
     6           #
     5       #   #
     4     # #   #
     3     # # # #
     2 #   # # # #
     1 # # # # # #
     _ _ _ _ _ _ _
       2 1 4 5 3 7

Looking at the above histogram, the largest rectangle (4 x 3) is formed by
columns (4, 5, 3 and 7).

Output: 12

Example 2:

Input: @A = (3, 2, 3, 5, 7, 5)

     7         #
     6         #
     5       # # #
     4       # # #
     3 #   # # # #
     2 # # # # # #
     1 # # # # # #
     _ _ _ _ _ _ _
       3 2 3 5 7 5

Looking at the above histogram, the largest rectangle (3 x 5) is formed by
columns (5, 7 and 5).

Output: 15

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;                        # Exports const()
use List::MoreUtils qw( pairwise );
use List::Util      qw( max );
use Regexp::Common  qw( number );       # Exports %RE{num}

const my $USAGE =>
"Usage:
  perl $0 [<A> ...]

    [<A> ...]    Non-empty sequence of positive integers\n";

const my $MAX_COLUMNS => 38;     # (For my particular command-line screen setup)
const my $MAX_HEIGHT  => 31;     #  N.B.: The logic in print_histogram() below
                                 #        assumes that $MAX_HEIGHT < 100

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 075, Task #2: Largest Rectangle Histogram (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my @A = parse_command_line();

    print_histogram(@A);

    my $rect = find_largest_rectangle(@A);

    if ($rect->{area} == 0)
    {
        print  "\nThe histogram contains no rectangles\n\nArea: 0\n";
    }
    else
    {
        printf "\nThe largest rectangle (%d x %d) has corners at (C%d, R1) " .
                 "and (C%d, R%d)\n\nArea: %d\n",
                  @{$rect}{ qw( width row_r col_l col_r row_r area ) };
    }
}

#===============================================================================
=comment

Assumptions
-----------

1. A single column (vertical bar) is a rectangle of width 1.
2. If two or more rectangles have the maximum area, only the first to be found
   is given as "the largest rectangle".

Algorithm
---------

In a histogram, all bars are anchored in the first row, from which it follows
that any candidate for largest rectangle must have 2 of its 4 corners in the
first row. (If the rectangle is a single bar, its left and right lower corners
are identical.) A rectangle can be uniquely specified by any 2 diagonally-
opposite corners. In the solution below, these are the bottom left and top right
corners.

To check a given column C: for each row R in C, find the longest unbroken line
of non-empty squares to the immediate right of (C, R). Suppose the line for row
R ends in column D. Then the rectangle has corners (C, 1) and (D, R); the width
is D - C + 1; and the height is R.

Any column C to the right of the first needs to be checked iff A[c] > A[c-1],
because otherwise it's already been included in a check for a previous column.
By the same logic, if column C does need to be checked at all, only those rows >
A[c-1] need be checked.

=cut
#===============================================================================

#-------------------------------------------------------------------------------
sub find_largest_rectangle
#-------------------------------------------------------------------------------
{
    my @A    = @_;
    my @keys = qw( col_l col_r row_r width area );
    my %max  = map { $_ => 0 } @keys;

    for my $col_l (0 .. $#A)
    {
        my $prev_row = $col_l ? $A[$col_l - 1] : 0;
        my $this_row = $A[$col_l];

        if ($col_l == 0 || $this_row > $prev_row)
        {
            for my $row ($prev_row + 1 .. $this_row)
            {
                my $width = 1;
                my $col_r = $col_l;

                INNER: for my $col ($col_l + 1 .. $#A)
                {
                    if ($A[$col] >= $row)
                    {
                        ++$col_r;
                        ++$width;
                    }
                    else
                    {
                        last INNER;
                    }
                }

                if ((my $area = $width * $row) > $max{area})
                {
                    my @new = ($col_l + 1, $col_r + 1, $row, $width, $area);
                       %max = pairwise { $a => $b } @keys, @new;
                }
            }
        }
    }

    return \%max;
}

#-------------------------------------------------------------------------------
sub print_histogram
#-------------------------------------------------------------------------------
{
    my @A          = @_;
    my $columns    = scalar @A;
    my $max_height = max @A;

    if ($columns    <= $MAX_COLUMNS &&
        $max_height <= $MAX_HEIGHT)
    {
        for my $row (reverse 1 .. $max_height)
        {
            printf " %2d", $row;
            print  $_ >= $row ? ' #' : '  ' for @A;
            print  "\n";
        }

        printf "  _%s\n", ' _' x $columns;

        if ($max_height < 10)
        {
            printf "    %s\n", join ' ', @A;
        }
        else
        {
            printf "    %s\n", join ' ', map { int($_ / 10) || ' ' } @A;
            printf "    %s\n", join ' ', map {     $_ % 10         } @A;
        }
    }
    else
    {
        printf "The histogram is too %s to print on a single screen\n",
                $columns > $MAX_COLUMNS ? 'wide' : 'tall';
    }
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my @A = @ARGV;

    scalar @A > 0                                 or die $USAGE;
    defined($_) && /\A$RE{num}{int}\z/ && $_ >= 0 or die $USAGE for @A;

    return @A;
}

################################################################################
