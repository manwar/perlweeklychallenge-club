use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 288
=========================

TASK #2
-------
*Contiguous Block*

Submitted by: Peter Campbell Smith

You are given a rectangular matrix where all the cells contain either x or o.

Write a script to determine the size of the largest contiguous block.

    A contiguous block consists of elements containing the same symbol which
    share an edge (not just a corner) with other elements in the block, and
    where there is a path between any two of these elements that crosses only
    those shared edges.

Example 1

    Input: $matrix = [
                       ['x', 'x', 'x', 'x', 'o'],
                       ['x', 'o', 'o', 'o', 'o'],
                       ['x', 'o', 'o', 'o', 'o'],
                       ['x', 'x', 'x', 'o', 'o'],
                     ]
    Output: 11

        There is a block of 9 contiguous cells containing 'x'.
        There is a block of 11 contiguous cells containing 'o'.

Example 2

    Input: $matrix = [
                       ['x', 'x', 'x', 'x', 'x'],
                       ['x', 'o', 'o', 'o', 'o'],
                       ['x', 'x', 'x', 'x', 'o'],
                       ['x', 'o', 'o', 'o', 'o'],
                     ]
    Output: 11

        There is a block of 11 contiguous cells containing 'x'.
        There is a block of 9 contiguous cells containing 'o'.

Example 3

    Input: $matrix = [
                       ['x', 'x', 'x', 'o', 'o'],
                       ['o', 'o', 'o', 'x', 'x'],
                       ['o', 'x', 'x', 'o', 'o'],
                       ['o', 'o', 'o', 'x', 'x'],
                     ]
    Output: 7

        There is a block of 7 contiguous cells containing 'o'.
        There are two other 2-cell blocks of 'o'.
        There are three 2-cell blocks of 'x' and one 3-cell.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A single string is entered on the command-line, e.g., "xxxo xooo xooo xxoo".
   This string comprises whitespace-separated rows; each row contains only the characters 'x' or 'o'. The matrix represented must be rectangular and not
   empty.
3. If VERBOSE is set to True, the output is augmented with a matrix diagram
   showing the different contiguous blocks found, and identifying the largest.

=end comment
#===============================================================================

use Test;

my Bool constant VERBOSE = True;

subset Result of List where (UInt, Array[Str]);

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 288, Task #2: Contiguous Block (Raku)\n".put;
}

#===============================================================================
class Matrix
#===============================================================================
{
    subset Elem    of Str   where * ~~ 'x' | 'o';
    subset MatrixT of Array where * ~~ Array[Array[Str]];

    #---------------------------------------------------------------------------
    # Attributes
    #---------------------------------------------------------------------------

    has MatrixT $!matrix     is built;
    has UInt    $!rows       is built;
    has UInt    $!cols       is built;
    has Str     $!matrix-str is built;

    #---------------------------------------------------------------------------
    method new( Str:D $matrix-str )
    #---------------------------------------------------------------------------
    {
        return self.bless( :$matrix-str );
    }

    #---------------------------------------------------------------------------
    submethod TWEAK()
    #---------------------------------------------------------------------------
    {
        my Str  @rows = $!matrix-str.split: / \s+ /, :skip-empty;
                @rows.elems > 0                 or error( 'Empty matrix' );
        my UInt $cols = @rows[ 0 ].chars;

        @rows[ 0 ] ~~ / ^ <[ x o ]>+ $ /        or error( 'Invalid character' );

        $!matrix = Array[Array[Str]].new;

        $!matrix.push: Array[Str].new: @rows[ 0 ].split: '', :skip-empty;

        for 1 .. @rows.end -> UInt $i
        {
            @rows[ $i ] ~~ / ^ <[ x o ]>+ $ /   or error( 'Invalid character' );
            @rows[ $i ].chars == $cols          or error( 'Ragged array' );

            $!matrix.push: Array[Str].new: @rows[ $i ].split: '', :skip-empty;
        }

        $!rows = $!matrix.elems;
        $!cols = $!matrix[ 0 ].elems;
    }

    #---------------------------------------------------------------------------
    method find-largest-block-size( --> Result:D )
    #---------------------------------------------------------------------------
    {
        my UInt $x-num = 0;
        my UInt $o-num = 0;

        for 0 .. $!rows - 1 -> UInt $row
        {
            for 0 .. $!cols - 1 -> UInt $col
            {
                my Str $elem = $!matrix[ $row; $col ];

                if $elem ~~ Elem:D
                {
                    my UInt $num = ($elem eq 'x') ?? $x-num++ !! $o-num++;

                    self!find-block( $elem, "$elem$num", $row, $col );
                }
            }
        }

        return self!count-blocks;
    }

    #---------------------------------------------------------------------------
    method !find-block( Elem:D $elem, Str:D $marker, Int:D $row, Int:D $col )
    #---------------------------------------------------------------------------
    {
        $!matrix[ $row; $col ] = $marker;

        self!search-up(    $elem, $marker, $row, $col );
        self!search-left(  $elem, $marker, $row, $col );
        self!search-right( $elem, $marker, $row, $col );
        self!search-down(  $elem, $marker, $row, $col );
    }

    #---------------------------------------------------------------------------
    method !search-up( Elem:D $elem, Str:D $marker, Int:D $row, Int:D $col )
    #---------------------------------------------------------------------------
    {
        if $row > 0
        {
            my Int $up-row = $row - 1;

            if  $!matrix[ $up-row; $col ] eq $elem
            {
                $!matrix[ $up-row; $col ] = $marker;

                self!find-block( $elem, $marker, $up-row, $col );
            }
        }
    }

    #---------------------------------------------------------------------------
    method !search-left( Elem:D $elem, Str:D $marker, Int:D $row, Int:D $col )
    #---------------------------------------------------------------------------
    {
        if $col > 0
        {
            my Int $left-col = $col - 1;

            if  $!matrix[ $row; $left-col ] eq $elem
            {
                $!matrix[ $row; $left-col ] = $marker;

                self!find-block( $elem, $marker, $row, $left-col );
            }
        }
    }

    #---------------------------------------------------------------------------
    method !search-right( Elem:D $elem, Str:D $marker, Int:D $row, Int:D $col )
    #---------------------------------------------------------------------------
    {
        if $col < $!cols - 1
        {
            my Int $right-col = $col + 1;

            if  $!matrix[ $row; $right-col ] eq $elem
            {
                $!matrix[ $row; $right-col ] = $marker;

                self!find-block( $elem, $marker, $row, $right-col );
            }
        }
    }

    #---------------------------------------------------------------------------
    method !search-down( Elem:D $elem, Str:D $marker, Int:D $row, Int:D $col )
    #---------------------------------------------------------------------------
    {
        if $row < $!rows - 1
        {
            my Int $down-row = $row + 1;

            if  $!matrix[ $down-row; $col ] eq $elem
            {
                $!matrix[ $down-row; $col ] = $marker;

                self!find-block( $elem, $marker, $down-row, $col );
            }
        }
    }

    #---------------------------------------------------------------------------
    method !count-blocks( --> Result:D )
    #---------------------------------------------------------------------------
    {
        my UInt %block-counts{Str};

        for 0 .. $!rows - 1 -> UInt $row
        {
            for 0 .. $!cols - 1 -> UInt $col
            {
                ++%block-counts{ $!matrix[ $row; $col ] };
            }
        }

        my UInt       $max-size   = %block-counts.values.max;
        my Array[Str] $max-blocks = Array[Str].new;

        for %block-counts.kv -> Str $key, UInt $value
        {
            $max-blocks.push: $key if $value == $max-size;
        }

        $max-blocks = Array[Str].new: $max-blocks.sort:
                        {
                            $^a.substr( 0, 1 ) cmp $^b.substr( 0, 1 )
                                               ||
                            $^a.substr( 1 )    <=> $^b.substr( 1 )
                        };

        return $max-size, $max-blocks;
    }

    #---------------------------------------------------------------------------
    method print( Str:D $prefix )
    #---------------------------------------------------------------------------
    {
        my Str  $tab   = ' ' x $prefix.chars;
        my UInt @width = 1  xx $!matrix[ 0 ].elems;

        for @$!matrix -> Array[Str] $row
        {
            for 0 .. $row.end -> UInt $i
            {
                my UInt $w = $row[ $i ].chars;

                @width[ $i ] = $w if $w > @width[ $i ];
            }
        }

        "$prefix\[".put;

        for @$!matrix -> Array[Str] $row
        {
            my Str @row-str;

            for 0 .. $row.end -> UInt $i
            {
                @row-str.push: '%*s'.sprintf: @width[ $i ], $row[ $i ];
            }

            "%s  [%s]\n".printf: $tab, @row-str.map( { "'$_'" } ).join: ', ';
        }

        "$tab]".put;
    }
}

#===============================================================================
multi sub MAIN
(
    Str:D $matrix-str    #= Non-empty matrix string, e.g., "xxxo xooo xooo xxoo"
)
#===============================================================================
{
    my Matrix $matrix = Matrix.new( $matrix-str );

    $matrix.print( 'Input: $matrix = ' );

    my Result $result = $matrix.find-largest-block-size;

    "Output: %d\n".printf: $result[ 0 ];

    if VERBOSE
    {
        put();
        $matrix.print( 'Blocks: ' );

        my Array[Str] $max-blocks = $result[ 1 ];

        "Largest block%s: %s\n".printf:
            $max-blocks.elems > 1 ?? 's' !! '', $max-blocks.join: ', ';
    }
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $matrix-str, $expected) = $line.split: / \| /;

        for     $test-name, $matrix-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Matrix $matrix   =  Matrix.new( $matrix-str );
        my UInt   $max-size = $matrix.find-largest-block-size[ 0 ];

        is $max-size, $expected.Int, $test-name;
    }

    done-testing;
}

#-------------------------------------------------------------------------------
sub error( Str:D $message )
#-------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#-------------------------------------------------------------------------------
sub test-data( --> Str:D )
#-------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|xxxxo xoooo xoooo xxxoo|11
        Example 2|xxxxx xoooo xxxxo xoooo|11
        Example 3|xxxoo oooxx oxxoo oooxx| 7
        END
}

################################################################################
