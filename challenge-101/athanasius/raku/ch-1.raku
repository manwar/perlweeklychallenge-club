use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 101
=========================

Task #1
-------
*Pack a Spiral*

Submitted by: Stuart Little

You are given an array @A of items (integers say, but they can be anything).

Your task is to pack that array into an MxN matrix spirally counterclockwise,
as tightly as possible.

    'Tightly' means the absolute value |M-N| of the difference has to be as
    small as possible.

Example 1:

 Input: @A = (1,2,3,4)

 Output:

     4 3
     1 2

 Since the given array is already a 1x4 matrix on its own, but that's not as
 tight as possible. Instead, you'd spiral it counterclockwise into

     4 3
     1 2

Example 2:

 Input: @A = (1..6)

 Output:

     6 5 4
     1 2 3

 or

     5 4
     6 3
     1 2

 Either will do as an answer, because they're equally tight.

Example 3:

 Input: @A = (1..12)

 Output:

        9  8  7 6
       10 11 12 5
        1  2  3 4

 or

        8  7 6
        9 12 5
       10 11 4
        1  2 3

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 101, Task #1: Pack a Spiral (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    *@A where { @A.elems > 0 }          #= A non-empty array of integers and/or
                                        #= integer ranges: I..J
)
#==============================================================================
{
    # (1) Populate and validate the array

    my Int @a = get-array( @A );

    "Input: \@A = (%s)\n".printf: @a.join: ',';

    # (2) Find M <= N such that M * N == @A.elems and |M - N| is a minimum

    my UInt ($M, $N) = find-dimensions( @a );

    # (3) Create and populate the M x N matrix

    my Array[Int] @matrix = pack-matrix( @a, $M, $N );

    # (4) Print the matrix

    "\nOutput:\n".put;

    print-matrix( @matrix );
}

#------------------------------------------------------------------------------
sub get-array( Array:D[IntStr:D] $A --> Array:D[Int:D] )
#------------------------------------------------------------------------------
{
    my Int @a;

    for @$A -> Str $item
    {
        if $item ~~ / ^ (.+) \.\. (.+) $ /
        {
            $0.Int ~~ Int:D or error( qq[Item "$0" is not an integer] );
            $1.Int ~~ Int:D or error( qq[Item "$1" is not an integer] );
            @a.append: $0 .. $1;
        }
        else
        {
            $item ~~ Int:D or error( qq[Item "$item" is not an integer] );
            @a.push: $item.Int;
        }
    }

    return @a;
}

#------------------------------------------------------------------------------
sub find-dimensions( Array:D[Int:D] $A --> List:D[UInt:D, UInt:D] )
#------------------------------------------------------------------------------
{
    my UInt ($M, $N) = 1, $A.elems;

    unless $N.is-prime
    {
        my UInt $root = $N.sqrt.Int;

        if $root * $root == $N
        {
            ($M, $N) = $root, $root;
        }
        else
        {
            for (2 .. $root).reverse -> UInt $div1
            {
                my UInt $div2 = ($N / $div1).Int;

                if $div1 * $div2 == $N
                {
                    ($M, $N) = $div1, $div2;
                    last;
                }
            }
        }
    }

    return $M, $N;
}

#------------------------------------------------------------------------------
sub pack-matrix
(
    Array:D[Int:D] $A,
    UInt:D         $M,
    UInt:D         $N
--> Array:D[Array:D[Int:D]]
)
#------------------------------------------------------------------------------
{
    enum DIR < RIGHT UP LEFT DOWN >;

    my Array[Int] @matrix  =  Array[Int].new xx $M;
    my UInt       $max-row =  $M - 1;
    my UInt       $min-row =  0;
    my UInt       $max-col =  $N - 1;
    my UInt       $min-col =  0;
    my Int        $row     =  $max-row;
    my Int        $col     = -1;
    my DIR        $dir     =  RIGHT;

    for @$A -> Int $item
    {
        given $dir
        {
            when RIGHT
            {
                if ++$col > $max-col
                {
                    $col = $max-col;
                    $dir = UP;
                  --$row;
                  --$max-row;
                }
            }

            when UP
            {
                if --$row < $min-row
                {
                    $row = $min-row;
                    $dir = LEFT;
                  --$col;
                  --$max-col;
                }
            }

            when LEFT
            {
                if --$col < $min-col
                {
                    $col = $min-col;
                    $dir = DOWN;
                  ++$row;
                  ++$min-row;
                }
            }

            when DOWN
            {
                if ++$row > $max-row
                {
                    $row = $max-row;
                    $dir = RIGHT;
                  ++$col;
                  ++$min-col;
                }
            }
        }

        @matrix[ $row; $col ] = $item;
    }

    return @matrix;
}

#------------------------------------------------------------------------------
sub print-matrix( Array:D[Array:D[Int:D]] $matrix )
#------------------------------------------------------------------------------
{
    my UInt @widths;
    my UInt $max-row = $matrix.end;
    my UInt $max-col = $matrix[ 0 ].end;

    # (1) Calculate maximum column widths

    for 0 .. $max-col -> UInt $col
    {
        my UInt $max = $matrix[ 0; $col ].chars;

        for 1 .. $max-row -> UInt $row
        {
            $max = ( $max, $matrix[ $row; $col ].chars ).max;
        }

        @widths.push: $max;
    }

    # (2) Print the matrix

    for 0 .. $max-row -> UInt $row
    {
        (' ' x 5).print;

        for 0 .. $max-col -> UInt $col
        {
            " %*d".printf: @widths[ $col ], $matrix[ $row; $col ];
        }

        ''.put;
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

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;
    $usage.put;
}

##############################################################################
