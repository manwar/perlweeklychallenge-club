use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 079
=========================

Task #2
-------
*Trapped Rain Water*

Submitted by: Mohammad S Anwar

You are given an array of positive numbers @N.

Write a script to represent it as Histogram Chart and find out how much water
it can trap.

Example 1:

Input: @N = (2, 1, 4, 1, 2, 5)
The histogram representation of the given array is as below.

         5           #
         4     #     #
         3     #     #
         2 #   #   # #
         1 # # # # # #
         _ _ _ _ _ _ _
           2 1 4 1 2 5

Looking at the above histogram, we can see, it can trap 1 unit of rain water
between 1st and 3rd column. Similary it can trap 5 units of rain water between
3rd and last column.

Therefore your script should print 6.

Example 2:

Input: @N = (3, 1, 3, 1, 1, 5)
The histogram representation of the given array is as below.

         5           #
         4           #
         3 #   #     #
         2 #   #     #
         1 # # # # # #
         _ _ _ _ _ _ _
           3 1 3 1 1 5

Looking at the above histogram, we can see, it can trap 2 units of rain water
between 1st and 3rd column. Also it can trap 4 units of rain water between 3rd
and last column.

Therefore your script should print 6.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Notes
-----
To imagine the histogram trapping water, we have to also imagine (transparent!)
walls in front and behind. It seems perfectly in keeping to also imagine a
floor beneath row 1. Therefore, rows with 0 height can still trap water, pro-
vided there are walls to the left and right.

The algorithm used is naive but simple (and therefore straightforward to imple-
ment): for every empty square in the histogram, determine whether there are
walls to its left and right; if so, it can trap rain water.

Note that no water can be trapped in the left-most or right-most columns.

=end comment
#==============================================================================

my UInt constant $MAX-COLUMNS = 38;    # (For my particular command-line setup)
my UInt constant $MAX-HEIGHT  = 31;    #  N.B.: The logic in print-histogram()
                                       #        below assumes $MAX-HEIGHT < 100

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 079, Task #2: Trapped Rain Water (Raku)\n".put;
}

##=============================================================================
sub MAIN
(
    *@N where { @N.elems > 0 &&       #= A non-empty array of positive integers
                .all ~~ UInt:D }
)
##=============================================================================
{
    "Input: \@N = (%s)\n\n".printf: @N.join: ', ';
    "Histogram representation:\n".put;

    print-histogram(@N);

    my UInt $water = 0;

    for 1 .. @N.end - 1 -> UInt $col
    {
        for @N[$col] + 1 .. @N.max -> UInt $row
        {
            ++$water if is-wall-left( @N, $col, $row) &&
                        is-wall-right(@N, $col, $row);
        }
    }

    "\nThis histogram can trap $water units of rain water".put;
}

#------------------------------------------------------------------------------
sub is-wall-left(Array:D[UInt:D] $N, UInt:D $column, UInt:D $row --> Bool:D)
#------------------------------------------------------------------------------
{
    for (0 .. $column - 1).reverse -> UInt $col
    {
        return True if $N[$col] >= $row;
    }

    return False;
}

#------------------------------------------------------------------------------
sub is-wall-right(Array:D[UInt:D] $N, UInt:D $column, UInt:D $row --> Bool:D)
#------------------------------------------------------------------------------
{
    for $column + 1 .. $N.end -> UInt $col
    {
        return True if $N[$col] >= $row;
    }

    return False;
}

#------------------------------------------------------------------------------
# From Perl Weekly Challenge #075, Task 2: Largest Rectangle Histogram
#
sub print-histogram(Array:D[UInt:D] $A)
#------------------------------------------------------------------------------
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

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

###############################################################################
