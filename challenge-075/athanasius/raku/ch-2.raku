use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

use List::UtilsBy <zip_by>;

my UInt constant $MAX-COLUMNS = 38;     # (For my particular command-line setup)
my UInt constant $MAX-HEIGHT  = 31;     #  N.B.: The logic in print-histogram()
                                        #        below assumes $MAX-HEIGHT < 100

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 075, Task #2: Largest Rectangle Histogram (Raku)\n".put;
}

##==============================================================================
sub MAIN
(
    *@A where { @A.elems > 0  &&      #= Non-empty sequence of positive integers
                @A.all  ~~ UInt:D }
)
##==============================================================================
{
    print-histogram(@A);

    my UInt %rect = find-largest-rectangle(@A);

    if %rect<area> == 0
    {
        "\nThe histogram contains no rectangles\n\nArea: 0".put;
    }
    else
    {
        ("\nThe largest rectangle (%d x %d) has corners at " ~
            "(C%d, R1) and (C%d, R%d)\n\nArea: %d\n").printf:
                %rect<width row-r col-l col-r row-r area>;
    }
}

#===============================================================================
=begin comment

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

=end comment
#===============================================================================

#-------------------------------------------------------------------------------
sub find-largest-rectangle(Array:D[UInt:D] $A --> Hash:D[UInt:D])
#-------------------------------------------------------------------------------
{
    my Str  @keys = <col-l col-r row-r width area>;
    my UInt %max  = @keys.map: { $_ => 0 };

    for 0 .. $A.end -> UInt $col-l
    {
        my UInt $prev-row = $col-l ?? $A[$col-l - 1] !! 0;
        my UInt $this-row = $A[$col-l];

        if ($col-l == 0 || $this-row > $prev-row)
        {
            for $prev-row + 1 .. $this-row -> UInt $row
            {
                my UInt $width = 1;
                my UInt $col-r = $col-l;

                INNER: for $col-l + 1 .. $A.end -> UInt $col
                {
                    if $A[$col] >= $row
                    {
                        ++$col-r;
                        ++$width;
                    }
                    else
                    {
                        last INNER;
                    }
                }

                if (my UInt $area = $width * $row) > %max<area>
                {
                    %max = zip_by { |@_ }, @keys, ($col-l + 1, $col-r + 1, $row,
                                                   $width, $area);
                }
            }
        }
    }

    return %max;
}

#-------------------------------------------------------------------------------
sub print-histogram(Array:D[UInt:D] $A)
#-------------------------------------------------------------------------------
{
    my UInt $columns    = $A.elems;
    my UInt $max-height = $A.max;

    if $columns    <= $MAX-COLUMNS &&
       $max-height <= $MAX-HEIGHT
    {
        for (1 .. $max-height).reverse -> UInt $row
        {
            ' %2d'.printf: $row;
            ' %s' .printf: $_ >= $row ?? '#' !! ' ' for $A.list;
            ''.put;
        }

        "  _%s\n".printf: ' _' x $columns;

        if $max-height < 10
        {
            "    %s\n".printf: $A.join: ' ';
        }
        else
        {
            "    %s\n".printf: $A.map( { ($_ / 10).floor || ' ' } ).join: ' ';
            "    %s\n".printf: $A.map( {  $_ % 10               } ).join: ' ';
        }
    }
    else
    {
        "The histogram is too %s to print on a single screen\n".printf:
            $columns > $MAX-COLUMNS ?? 'wide' !! 'tall';
    }
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

################################################################################
