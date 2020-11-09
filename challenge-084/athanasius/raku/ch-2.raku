use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 084
=========================

Task #2
-------
*Find Square*

Submitted by: Mohammad S Anwar

You are given matrix of size m x n with only 1 and 0.

Write a script to find the count of squares having all four corners set as 1.

Example 1:

 Input: [ 0 1 0 1 ]
        [ 0 0 1 0 ]
        [ 1 1 0 1 ]
        [ 1 0 0 1 ]

 Output: 1

Explanation:

There is one square (3x3) in the given matrix with four corners as 1 starts at
r=1;c=2.

 [ 1 0 1 ]
 [ 0 1 0 ]
 [ 1 0 1 ]

Example 2:

 Input: [ 1 1 0 1 ]
        [ 1 1 0 0 ]
        [ 0 1 1 1 ]
        [ 1 0 1 1 ]

 Output: 4

Explanation:

There is one square (4x4) in the given matrix with four corners as 1 starts at
r=1;c=1.

There is one square (3x3) in the given matrix with four corners as 1 starts at
r=1;c=2.

There are two squares (2x2) in the given matrix with four corners as 1. First
starts at r=1;c=1 and second starts at r=3;c=3.

Example 3:

 Input: [ 0 1 0 1 ]
        [ 1 0 1 0 ]
        [ 0 1 0 0 ]
        [ 1 0 0 1 ]

 Output: 0

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

my Bool constant $EXPLAIN = True;

subset Element where 1|0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 084, Task #2: Find Square (Raku)\n".put;
}

##=============================================================================
sub MAIN
(
    *@rows where { @rows\  .elems > 0 &&      #= 1+ same-width rows, each a
                   @rows[0].chars > 0 }       #= string of 1+ "1" and "0" chars
)
##=============================================================================
{
    my Str @str-rows = @rows;

    my Array[Element] @A = get-matrix(@str-rows);

    print-matrix(@A);

    my UInt $width    = @A[0].elems;
    my UInt $height   = @A\  .elems;
    my UInt $max-side = $width <= $height ?? $width !! $height;
    my UInt $count    = 0;

    my Array[UInt] @squares;

    for 0 .. $height - 2 -> UInt $row-top
    {
        for 0 .. $width - 2 -> UInt $col-left
        {
            next unless @A[$row-top;$col-left] eq '1';

            for 1 .. $max-side -> UInt $side
            {
                my UInt $col-right = $col-left + $side;

                next unless $col-right < $width &&
                            @A[$row-top;$col-right] eq '1';

                my $row-bottom = $row-top + $side;

                next unless $row-bottom < $height             &&
                            @A[$row-bottom;$col-left ] eq '1' &&
                            @A[$row-bottom;$col-right] eq '1';

                ++$count;

                if $EXPLAIN
                {
                    @squares.push: Array[UInt].new($row-top + 1, $col-left + 1,
                                                   $side    + 1);
                }
            }
        }
    }

    " Output: $count".put;

    if $EXPLAIN && @squares.elems > 0
    {
        "\nExplanation:\n".put;

        for @squares
        {
            " %dx%d square with top left corner at row %d, column %d\n".printf:
                $_[2, 2, 0, 1];
        }
    }
}

#------------------------------------------------------------------------------
sub get-matrix( Str:D @rows --> Array:D[Element:D] )
#------------------------------------------------------------------------------
{
    my Array[Element] @matrix[ @rows.elems ];

    my UInt $width = @rows[0].chars;

    for 0 .. @rows.end -> UInt $i
    {
        my Str $row = @rows[$i];

        $row ~~ / ( <-[ 1 0 ]> ) /
            and error("Invalid character '$0' in the input matrix");

        $row.chars == $width
            or  error("Inconsistent number of columns in row { $i + 1 }");

        my Element @chars = $row.split: '', :skip-empty;

        @matrix[$i] = @chars;
    }

    return @matrix;
}

#------------------------------------------------------------------------------
sub print-matrix( Array:D[Element:D] @matrix )
#------------------------------------------------------------------------------
{
    " Input: [ %s ]\n".printf: @matrix[0 ].join: ' ';
    "        [ %s ]\n".printf: @matrix[$_].join: ' ' for 1 .. @matrix.end;

    ''.put;
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

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

###############################################################################
