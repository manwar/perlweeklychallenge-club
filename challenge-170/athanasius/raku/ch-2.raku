use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 170
=========================

TASK #2
-------
*Kronecker Product*

Submitted by: Mohammad S Anwar

You are given 2 matrices.

Write a script to implement Kronecker Product on the given 2 matrices.

For more information, please refer
[ https://en.wikipedia.org/wiki/Kronecker_product |wikipedia page].


For example,

 A = [ 1 2 ]
     [ 3 4 ]

 B = [ 5 6 ]
     [ 7 8 ]

 A x B = [ 1 x [ 5 6 ]   2 x [ 5 6 ] ]
         [     [ 7 8 ]       [ 7 8 ] ]
         [ 3 x [ 5 6 ]   4 x [ 5 6 ] ]
         [     [ 7 8 ]       [ 7 8 ] ]

       = [ 1x5 1x6 2x5 2x6 ]
         [ 1x7 1x8 2x7 2x8 ]
         [ 3x5 3x6 4x5 4x6 ]
         [ 3x7 3x8 4x7 4x8 ]

       = [  5  6 10 12 ]
         [  7  8 14 16 ]
         [ 15 18 20 24 ]
         [ 21 24 28 32 ]

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
Each of the two input matrices is entered on the command line as a string, with
rows separated by vertical bars ("|"), and, within each row, real-number
elements separated by commas. For example:

    raku ch-1.raku "1,2|3,4" "5,6|7,8"

=end comment
#==============================================================================

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 170, Task #2: Kronecker Product (Raku)\n".put;
}

#------------------------------------------------------------------------------
class X::Input is Exception
#------------------------------------------------------------------------------
{
}

#------------------------------------------------------------------------------
class X::Input::Real is X::Input
#------------------------------------------------------------------------------
{
    method message( --> Str:D )
    {
        return 'Invalid real number';
    }
}

#------------------------------------------------------------------------------
class X::Input::Columns is X::Input
#------------------------------------------------------------------------------
{
    method message( --> Str:D )
    {
        return 'Inconsistent number of columns in row';
    }
}

#==============================================================================
sub MAIN
(
    Str:D $A,    #= Matrix A (string: columns separated by ',' and rows by '|')
    Str:D $B     #= Matrix B (string: columns separated by ',' and rows by '|')
)
#==============================================================================
{
    my Array[Real] @matrix-A = build-matrix( $A );
    my Array[Real] @matrix-B = build-matrix( $B );

    "%s\n%s\n".printf: sprint-matrix( 'A', @matrix-A ),
                       sprint-matrix( 'B', @matrix-B );

    # Calculate the Kronecker product

    my Array[Real] @matrix-K = kronecker( @matrix-A, @matrix-B );

    sprint-matrix( 'A x B', @matrix-K ).print;

    CATCH
    {
        when X::Input
        {
            $*ERR.put: 'ERROR: ' ~ .message;
            USAGE();
        }
    }
}

#------------------------------------------------------------------------------
sub kronecker
(
    Array:D[Array:D[Real:D]] $matrix-A,
    Array:D[Array:D[Real:D]] $matrix-B,
--> Array:D[Array:D[Real:D]]
)
#------------------------------------------------------------------------------
{
    my UInt ($rows-A, $cols-A) = +$matrix-A, +$matrix-A[ 0 ];
    my UInt ($rows-B, $cols-B) = +$matrix-B, +$matrix-B[ 0 ];

    my Array[Real] @matrix-K = Array[Array[Real]].new:
                               Array[Real].new xx ($rows-A * $rows-B);

    for 0 .. $rows-A - 1 -> UInt $row-A
    {
        for 0 .. $cols-A - 1 -> UInt $col-A
        {
            for 0 .. $rows-B - 1 -> UInt $row-B
            {
                my UInt $row-K = ($row-A * $rows-B) + $row-B;

                for 0 .. $cols-B - 1 -> UInt $col-B
                {
                    my UInt $col-K = ($col-A * $cols-B) + $col-B;

                    @matrix-K[ $row-K; $col-K ] = $matrix-A[ $row-A; $col-A ] *
                                                  $matrix-B[ $row-B; $col-B ];
                }
            }
        }
    }

    return @matrix-K;
}

#------------------------------------------------------------------------------
sub build-matrix( Str:D $rep --> Array:D[Array:D[Real:D]] )
#------------------------------------------------------------------------------
{
    my Array[Real] @matrix;
    my Str         @row-strs = $rep.split: '|', :skip-empty;

    for 0 .. @row-strs.end -> UInt $j
    {
        my Str  $row-str = @row-strs[ $j ];
        my Real @cols;

        try
        {
            @cols = $row-str.split( ',', :skip-empty ).map: { .Real };

            CATCH
            {
                X::Input::Real.new.throw when X::Str::Numeric;
            }
        }

        $j == 0 || +@cols == +@matrix[ 0 ] or X::Input::Columns.new.throw;

        push @matrix, @cols;
    }

    return @matrix;
}

#------------------------------------------------------------------------------
sub sprint-matrix( Str:D $name, Array:D[Array:D[Real:D]] $matrix --> Str:D )
#------------------------------------------------------------------------------
{
    my Array[Str] @str-matrix = format-elements( $matrix );
    my Str        $out        = "%s = [ %s ]\n".sprintf:
                                 $name, @str-matrix[ 0 ].list.join: ' ';
    my Str        $prefix     = ' ' x ($name.chars + 3);

    for 1 .. $matrix.end -> UInt $i
    {
        $out ~= "%s\[ %s \]\n".sprintf:
                 $prefix, @str-matrix[ $i ].list.join: ' ';
    }

    return $out;
}

#------------------------------------------------------------------------------
sub format-elements
(
    Array:D[Array:D[Real:D]] $matrix
--> Array:D[Array:D[Str:D]]
)
#------------------------------------------------------------------------------
{
    my UInt @max-widths = get-widths( $matrix );   # Find maximum column widths

    # Convert each element to a string and left-justify with spaces as required

    my Array[Str] @new-matrix;
    my UInt       $col-end = $matrix[ 0 ].elems - 1;

    for 0 .. $matrix.end -> UInt $row
    {
        my Str @new-row;

        for 0 .. $col-end -> UInt $col
        {
            my Real $element = $matrix[ $row; $col ];

            @new-row.push: "% *s".sprintf: @max-widths[ $col ], $element;
        }

        @new-matrix.push: @new-row;
    }

    return @new-matrix;
}

#------------------------------------------------------------------------------
sub get-widths( Array:D[Array:D[Real:D]] $matrix --> Array:D[UInt:D] )
#------------------------------------------------------------------------------
{
    my UInt @max-widths;
    my UInt $col-end = $matrix[ 0 ].elems - 1;

    for 0 .. $col-end -> UInt $col
    {
        my UInt $max-width;

        for 0 .. $matrix.end -> UInt $row
        {
            my UInt $width = $matrix[ $row; $col ].Str.chars;

            $max-width = $width if !$max-width.defined || $width > $max-width;
        }

        @max-widths.push: $max-width;
    }

    return @max-widths
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
