use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 064
=========================

Task #1
-------
*Minimum Sum Path*

*Submitted by:* Mohammad S Anwar
*Reviewed by:* Ryan Thompson

Given an _m × n_ matrix with non-negative integers, write a script to find a
path from top left to bottom right which minimizes the sum of all numbers along
its path. You can only move either down or right at any point in time.

*Example*

Input:

  [ 1 2 3 ]
  [ 4 5 6 ]
  [ 7 8 9 ]

The minimum sum path looks like this:

  1→2→3
      ↓
      6
      ↓
      9

Thus, your script could output: 21 ( 1 → 2 → 3 → 6 → 9 )

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

my constant EXAMPLE = [1, 2, 3], [4, 5, 6], [7, 8, 9];

#-------------------------------------------------------------------------------
BEGIN ''.put;
#-------------------------------------------------------------------------------

#===============================================================================
sub MAIN( Str:D $file = 'DEFAULT' )           #= [path/]name of matrix data file
#===============================================================================
{
    "Challenge 064, Task #1: Minimum Sum Path (Raku)\n".put;

    my Array[UInt] @matrix;

    if $file eq 'DEFAULT'
    {
        @matrix = EXAMPLE.map: { Array[UInt].new: $_ };
    }
    else
    {
        for $file.IO.lines -> Str $line
        {
            @matrix.push: Array[UInt].new: $line.split(',').map: { .UInt };
        }
    }

    my       UInt  $rows = @matrix.elems    - 1;
    my       UInt  $cols = @matrix[0].elems - 1;
    my Array[UInt] @sums = find-min-sums(@matrix,        $rows, $cols);
    my       UInt  @path = find-min-path(@matrix, @sums, $rows, $cols);

    "%d ( %s )\n".printf: @sums[0; 0], @path.join: ' -> ';
}

#-------------------------------------------------------------------------------
sub find-min-sums
(
    Array[UInt] @matrix,
    UInt:D      $rows,
    UInt:D      $cols,
--> Array[Array[UInt]]
)
#-------------------------------------------------------------------------------
{
    my Array[UInt] @sums;
                   @sums.push: Array[UInt].new: 0 xx $cols for 0 .. $rows;

    # Calculate the minimal right-or-down path sum for each matrix element,
    # beginning at the bottom right corner and moving left and up. For a given
    # element at row r, column c, the minimal path sum is the matrix value for
    # (r,c) plus the smaller of the sums for (r+1,c) and (r,c+1).

    # Bottom right corner

    @sums[$rows; $cols] = @matrix[$rows; $cols];

    # Bottom row

    for (0 .. $cols - 1).reverse -> UInt $col
    {
        @sums[$rows; $col] = @matrix[$rows; $col] + @sums[$rows; $col + 1];
    }

    # Right column

    for (0 .. $rows - 1).reverse -> UInt $row
    {
        @sums[$row; $cols] = @matrix[$row; $cols] + @sums[$row + 1; $cols];
    }

    # Remaining rows, bottom to top

    for (0 .. $rows - 1).reverse -> UInt $row
    {
        # Remaining columns in this row, right to left

        for (0 .. $cols - 1).reverse -> UInt $col
        {
            my UInt $right = @sums[$row; $col + 1];
            my UInt $down  = @sums[$row + 1; $col];

            # Choose the smaller of the two path sums: right or down

            @sums[$row; $col] = @matrix[$row; $col] +
                                (($right <= $down) ?? $right !! $down);
        }
    }

    return @sums;
}

#-------------------------------------------------------------------------------
sub find-min-path
(
    Array[UInt] @matrix,
    Array[UInt] @sums,
    UInt:D      $rows,
    UInt:D      $cols,
--> Array[UInt]
)
#-------------------------------------------------------------------------------
{
    my UInt @path = @matrix[0; 0];
    my UInt $row  = 0;
    my UInt $col  = 0;

    until $row == $rows && $col == $cols
    {
        if    $row == $rows
        {
            @path.push: @matrix[$row; ++$col];
        }
        elsif $col == $cols
        {
            @path.push: @matrix[++$row; $col];
        }
        else
        {
            my UInt $right = @sums[$row; $col + 1];
            my UInt $down  = @sums[$row + 1; $col];

            if ($right <= $down)
            {
                @path.push: @matrix[$row; ++$col];
            }
            else
            {
                @path.push: @matrix[++$row; $col];
            }
        }
    }

    return @path;
}

################################################################################
