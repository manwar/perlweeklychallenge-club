use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 126
=========================

TASK #2
-------
*Minesweeper Game*

Submitted by: Cheok-Yin Fung

You are given a rectangle with points marked with either x or *. Please
consider the x as a land mine.

Write a script to print a rectangle with numbers and x as in the Minesweeper
game.

A number in a square of the minesweeper game indicates the number of mines
within the neighbouring squares (usually 8), also implies that there are no
bombs on that square.

Example

 Input:
     x * * * x * x x x x
     * * * * * * * * * x
     * * * * x * x * x *
     * * * x x * * * * *
     x * * * x * * * * x

 Output:
     x 1 0 1 x 2 x x x x
     1 1 0 2 2 4 3 5 5 x
     0 0 1 3 x 3 x 2 x 2
     1 1 1 x x 4 1 2 2 2
     x 1 1 3 x 2 0 0 1 x

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

my Str constant $FILE  = 'Example.txt';
my Str constant $MINE  = 'x';
my Str constant $EMPTY = '*';

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 126, Task #2: Minesweeper Game (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| The name of a file containing a Minesweeper starting grid

    Str:D $file where *.IO.f = $FILE
)
#==============================================================================
{
    my Array[Str] @in-grid = read-in-the-grid( $file );

    "Input from $file:".put;
    "    %s\n".printf: .join: ' ' for @in-grid;

    my Array[Str] @out-grid = number-the-grid( @in-grid );

    "\nOutput:".put;
    "    %s\n".printf: .join: ' ' for @out-grid;
}

#------------------------------------------------------------------------------
sub read-in-the-grid
(
    Str:D $file                     #= Input file
--> Array:D[Array:D[Str:D]]         #= Input grid
)
#------------------------------------------------------------------------------
{
    my Array[Str] @grid;

    for $file.IO.lines -> Str $line is copy
    {
        $line ~~ s:g/ \s+ //;

        @grid.push: Array[Str].new: $line.split: '', :skip-empty;
    }

    @grid.elems > 0 or error( 'Empty grid' );

    my UInt $width = @grid[ 0 ].elems;

    $width > 0      or error( 'Empty first row' );

    for 0 .. @grid.end -> UInt $row
    {
        @grid[ $row ].elems == $width
                    or error( 'The grid is not a rectangle' );

        for 0 .. @grid[ $row ].end -> UInt $col
        {
            my Str $point = @grid[ $row; $col ];

            $point eq $MINE || $point eq $EMPTY
                    or error( qq["$point" is not a valid input character] );
        }
    }

    return @grid;
}

#------------------------------------------------------------------------------
sub number-the-grid
(
    Array:D[Array:D[Str:D]] $in-grid        #= Input  grid
--> Array:D[Array:D[Str:D]]                 #= Output grid
)
#------------------------------------------------------------------------------
{
    my UInt       $max-row = $in-grid.end;
    my UInt       $max-col = $in-grid[ 0 ].end;
    my Array[Str] @out-grid;

    @out-grid.push: Array[Str].new: '0' xx ($max-col + 1) for 0 .. $max-row;

    for 0 .. $max-row -> UInt $row
    {
        for 0 .. $max-col -> UInt $col
        {
            if $in-grid[ $row; $col ] eq $MINE
            {
                @out-grid[ $row; $col ] = $MINE;
            }
            else
            {
                my UInt $count = 0;

                for $row - 1 .. $row + 1 -> Int $r
                {
                    next if $r < 0 || $r > $max-row;

                    for $col - 1 .. $col + 1 -> Int $c
                    {
                        next if $r == $row && $c == $col ||
                                $c < 0 || $c > $max-col;

                        ++$count if $in-grid[ $r; $c ] eq $MINE;
                    }
                }

                @out-grid[ $row; $col ] = $count.Str if $count;
            }
        }
    }

    return @out-grid;
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
