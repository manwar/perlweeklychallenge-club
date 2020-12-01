use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------

Two CLIs are provided:

1.  For an m x n matrix in which the elements are 1 to m * n in left-to-right,
    top-to-bottom order, the user may simply specify m and n explicitly; for
    example:

        raku ch-2.raku -m=4 -n=4

    produces the matrix in Example 2.

2.  For all other cases, the user must specify rows as whitespace-separated
    strings, each string being a comma-separated list of elements; for example:

        raku ch-2.raku  9,8,7  6,5,4  3,2,1

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

=end comment
#==============================================================================

subset Pos of Int where * > 0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 088, Task #2: Spiral Matrix (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    #| One or more same-width rows, each a comma-separated list of one or more
    #| positive integers

    *@rows where { @rows.elems > 0 && @rows[0].chars > 0 }
)
#==============================================================================
{
    my Str        @str-rows = @rows;
    my Array[Pos] @matrix   = get-matrix( @str-rows );

    main( @matrix );
}

#==============================================================================
multi sub MAIN
(
    Pos:D :$m,      #= Positive integer: matrix height (total number of rows)
    Pos:D :$n       #= Positive integer: matrix width (total number of columns)
)
#==============================================================================
{
    my Array[Pos] @matrix;

    my Pos $element = 1;

    for 0 ..^ $m -> UInt $row
    {
        @matrix[$row] = Array[Pos].new( $element ..^ $element + $n );

        $element += $n;
    }

    main( @matrix );
}

#------------------------------------------------------------------------------
sub main( Array:D[Pos:D] @matrix )
#------------------------------------------------------------------------------
{
    'Input:'.put;
    print-matrix( @matrix );

    my Pos @spiral = find-spiral( @matrix );

    "\nOutput:".put;
    "    [ %s ]\n".printf: @spiral.join: ' ';
}

#------------------------------------------------------------------------------
sub find-spiral( Array:D[Array:D[Pos:D]] $matrix --> Array:D[Pos:D] )
#------------------------------------------------------------------------------
{
    my Pos  @spiral;
    my UInt $max-row = $matrix\  .end;
    my UInt $max-col = $matrix[0].end;

    if    $max-row == 0                          # Base case (1): single row
    {
        @spiral = $matrix[0; *];
    }
    elsif $max-col == 0                          # Base case (2): single column
    {
        @spiral = $matrix[*; 0];
    }
    else
    {
        # Step 1: Read the outer matrix elements in clockwise order, beginning
        #         at the top left corner

        @spiral.append: $matrix[ 0;               *               ];   # Top
        @spiral.append: $matrix[ 1 .. $max-row;   $max-col        ];   # Right
        @spiral.append: $matrix[ $max-row;        $max-col ^... 0 ];   # Bottom
        @spiral.append: $matrix[ $max-row ^... 1; 0               ];   # Left

        # Step 2: Construct a new ("inner") matrix by removing the outer rows
        #         and columns

        my Array[Pos] @new-matrix;

        for 1 ..^ $max-row -> UInt $row
        {
            @new-matrix.push: Array[Pos].new( $matrix[$row; 1 ..^ $max-col] );
        }

        if @new-matrix.elems > 0 && @new-matrix[0].elems > 0
        {
            # Step 3: Recurse on the inner matrix

            @spiral.append: find-spiral( @new-matrix );
        }
      # else: Base case (3): the new matrix is empty
    }

    return @spiral;
}

#------------------------------------------------------------------------------
sub get-matrix( Str:D @rows --> Array:D[Array:D[Pos:D]] )
#------------------------------------------------------------------------------
{
    my Array[Pos] @matrix[ @rows.elems ];
    my UInt       $width;

    for 0 .. @rows.end -> UInt $i
    {
        my Str $row   = @rows[$i];
        my Str @words = $row.split: ',', :skip-empty;

        if $i == 0
        {
            $width = @words.elems;
        }
        else
        {
            @words.elems == $width
                or error( "Inconsistent number of columns in row { $i + 1 }" );
        }

        for @words -> Str $word
        {
            my Str $val = val( $word );

            $val ~~ IntStr:D or error( qq["$word" is not an integer] );

            my Int $num = $val.Int;

            $num > 0         or error( qq["$num" is not positive] );

            @matrix[$i].push: $num;
        }
    }

    return @matrix;
}

#------------------------------------------------------------------------------
sub print-matrix( Array:D[Pos:D] $matrix )
#------------------------------------------------------------------------------
{
    # 1. Pre-compute the maximum width of each matrix column

    my UInt @widths;

    for 0 .. $matrix[0].end -> UInt $col
    {
        my UInt $max-width = 0;

        for 0 .. $matrix.end -> UInt $row
        {
            my UInt $width = $matrix[$row; $col].chars;
            $max-width     = $width if $width > $max-width;
        }

        @widths[$col] = $max-width;
    }

    # 2. Print the matrix

    for 0 .. $matrix.end -> UInt $row
    {
        my Str @vals;

        for 0 .. $matrix[0].end -> UInt $col
        {
            @vals.push: '%*d'.sprintf: @widths[$col], $matrix[$row; $col];
        }

        "    [ %s ]\n".printf: @vals.join: ' ';
    }
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
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

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

###############################################################################
