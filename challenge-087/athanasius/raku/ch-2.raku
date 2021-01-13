use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

From Example 2, it is clear that the unit square [ 1 ] is not counted as a
"rectangle". But squares in general are rectangles, so the obvious conclusion
is that for the purposes of this Task an m x n rectangle must have m > 1 and
n > 1. Nevertheless, the constant $MIN-DIM is provided to allow different
constraints on the minimum dimensions of any candidate rectangle.

The algorithm is an exhaustive search, beginning with each "1" element in the
matrix which could (given the value of $MIN-DIM) be the upper, left-hand corner
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

=end comment
#==============================================================================

# The default value of $MIN-DIM is 2, ensuring that a rectangle has 4 distinct
# corners within the matrix. Set $MIN-DIM to 1 if single-width rectangles are
# to be allowed, e.g. [ 1 1 1 ]; but note that the unit square [ 1 ] will still
# be excluded.

my UInt constant $MIN-DIM = 2;

# Matrix elements must be "1" or "0" only

subset Element of Str where '1' | '0';

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 087, Task #2: Largest Rectangle (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| 1+ same-width rows, each a string of 1+ "1" & "0" chars

    *@rows where { @rows.elems > 0 && @rows[0].chars > 0 }
)
#==============================================================================
{
    my Str            @str-rows = @rows;
    my Array[Element] @matrix   = get-matrix(@str-rows);

    print-matrix(@matrix);

    my UInt ($rows, $cols) = find-max-rectangle(@matrix);

    if $rows >= $MIN-DIM &&
       $cols >= $MIN-DIM && ($rows > 1 || $cols > 1)
    {
        print-rectangle($rows, $cols);
    }
    else
    {
        'Output: 0'.put;
    }
}

#------------------------------------------------------------------------------
sub find-max-rectangle
(
    Array:D[Element:D] @matrix           #= The matrix to search
--> List:D[UInt:D]                       #= The height and width of the largest 
                                         #=   rectangle found
)
#------------------------------------------------------------------------------
{
    my UInt $max-row    = @matrix\  .elems - $MIN-DIM;
    my UInt $max-col    = @matrix[0].elems - $MIN-DIM;
    my UInt $max-area   = 0;
    my UInt $max-height = 0;
    my UInt $max-width  = 0;

    for 0 .. $max-row -> UInt $row
    {
        for 0 .. $max-col -> UInt $col
        {
            if @matrix[$row; $col] eq '1'
            {
                for &find-max-rect-right, &find-max-rect-down -> &func
                {
                    my UInt ($height, $width) = &func($row, $col, @matrix);

                    if (my UInt $area = $height * $width) > $max-area
                    {
                        $max-area   = $area;
                        $max-height = $height;
                        $max-width  = $width;
                    }
                }
            }
        }
    }

    return [$max-height, $max-width];
}

#------------------------------------------------------------------------------
sub find-max-rect-right
(
    UInt:D             $corner-row,     #= 0-based row of the upper left corner
    UInt:D             $corner-col,     #= 0-based col of the upper left corner
    Array:D[Element:D] @matrix,         #= The matrix to search
--> List:D[UInt]                        #= The height and width of the largest
                                        #=   rectangle found by a right-search
)
#------------------------------------------------------------------------------
{
    my UInt $max-row = @matrix\  .elems - 1;
    my UInt $max-col = @matrix[0].elems - 1;
    my UInt $width   = 1;

    for $corner-col + 1 .. $max-col -> UInt $c
    {
        if @matrix[$corner-row; $c] eq '1'
        {
            ++$width;
        }
        else
        {
            last;
        }
    }

    my UInt $height = 1;

    ROW:
    for $corner-row + 1 .. $max-row -> UInt $r
    {
        for $corner-col .. $corner-col + $width - 1 -> UInt $c
        {
            last ROW unless @matrix[$r; $c] eq '1';
        }

        ++$height;
    }

    return [$height, $width];
}

#------------------------------------------------------------------------------
sub find-max-rect-down
(
    UInt:D             $corner-row,     #= 0-based row of the upper left corner
    UInt:D             $corner-col,     #= 0-based col of the upper left corner
    Array:D[Element:D] @matrix,         #= The matrix to search
--> List:D[UInt]                        #= The height and width of the largest
                                        #=   rectangle found by a down-search
)
#------------------------------------------------------------------------------
{
    my UInt $max-row = @matrix\  .elems - 1;
    my UInt $max-col = @matrix[0].elems - 1;
    my UInt $height  = 1;

    for $corner-row + 1 .. $max-row -> UInt $r
    {
        if @matrix[$r; $corner-col] eq '1'
        {
            ++$height;
        }
        else
        {
            last;
        }
    }

    my UInt $width = 1;

    COLUMN:
    for $corner-col + 1 .. $max-col -> UInt $c
    {
        for $corner-row .. $corner-row + $height - 1 -> UInt $r
        {
            last COLUMN unless @matrix[$r; $c] eq '1';
        }

        ++$width;
    }

    return [$height, $width];
}

#------------------------------------------------------------------------------
sub get-matrix
(
    Str:D @rows          #= Matrix rows represented as strings of "1"s and "0"s
--> Array:D[Element:D]   #= The input matrix
)
#------------------------------------------------------------------------------
{
    my Array[Element] @matrix[ @rows.elems ];

    my UInt $width = @rows[0].chars;

    for 0 .. @rows.end -> UInt $i
    {
        my Str $row = @rows[$i];

        $row ~~ / ( <-[ 1 0 ]> ) /
            and error(qq[Invalid character "$0" in the input matrix]);

        $row.chars == $width
            or  error(qq[Inconsistent number of columns in row { $i + 1 }]);

        my Element @chars = $row.split: '', :skip-empty;

        @matrix[$i] = @chars;
    }

    return @matrix;
}

#------------------------------------------------------------------------------
sub print-matrix
(
    Array:D[Element:D] $matrix      #= The input matrix
)
#------------------------------------------------------------------------------
{
    'Input:'.put;

    for 0 .. $matrix.end -> UInt $i
    {
        "    [ %s ]\n".printf: $matrix[$i].join: ' ';
    }

    ''.put;
}

#------------------------------------------------------------------------------
sub print-rectangle
(
    UInt:D $rows,                   #= The height of an all-"1" rectangle
    UInt:D $cols                    #= The width  of an all-"1" rectangle
)
#------------------------------------------------------------------------------
{
    'Output:'.put;

    for 1 .. $rows
    {
        '    [ '.print;

        '1 '.print for 1 .. $cols;

        ']'.put;
    }
}

#------------------------------------------------------------------------------
sub error
(
    Str:D $message                  #= An error message
)
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit;
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
