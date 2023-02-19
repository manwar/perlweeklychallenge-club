use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 204
=========================

TASK #2
-------
*Reshape Matrix*

Submitted by: Mohammad S Anwar

You are given a matrix (m x n) and two integers (r) and (c).

Write a script to reshape the given matrix in form (r x c) with the original
value in the given matrix. If you can’t reshape print 0.

Example 1

  Input: [ 1 2 ]
         [ 3 4 ]

         $matrix = [ [ 1, 2 ], [ 3, 4 ] ]
         $r = 1
         $c = 4

  Output: [ 1 2 3 4 ]

Example 2

  Input: [ 1 2 3 ]
         [ 4 5 6 ]

         $matrix = [ [ 1, 2, 3 ] , [ 4, 5, 6 ] ]
         $r = 3
         $c = 2

  Output: [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]

          [ 1 2 ]
          [ 3 4 ]
          [ 5 6 ]

Example 3

  Input: [ 1 2 ]

         $matrix = [ [ 1, 2 ] ]
         $r = 3
         $c = 2

  Output: 0

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to True, and the solution matrix has more than one row,
   then the reshaped matrix is displayed again in two dimensions.
3. Elements in the original matrix are treated as strings, which may contain
   any non-whitespace characters other than "]".
4. The input matrix has the form "[ [ elem_1, elem_2, ... ], [ ... ], ... ]".
   Each row must be enclosed in square brackets. A separator (comma followed by
   optional whitespace) is optional between rows. Within a row, elements must
   be separated by either whitespace or commas (and commas may optionally be
   followed by whitespace). The sequence of rows must itself be enclosed in
   square brackets.

=end comment
#==============================================================================

use Test;

subset Pos of Int where * > 0;

my Bool constant $VERBOSE = True;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 204, Task #2: Reshape Matrix (Raku)\n".put;
}

#==============================================================================
multi sub MAIN
(
    Str:D $matrix,  #= Matrix represented as a string: "[ [ 1, 2 ], [ 3, 4 ] ]"
    Pos:D $r,       #= Number of rows    required in the reshaped matrix
    Pos:D $c        #= Number of columns required in the reshaped matrix
)
#==============================================================================
{
    my Array[Str] @matrix = parse-matrix-string( $matrix );

    "Input:  \$matrix = %s\n".printf: format-matrix_1D( @matrix );
    "        \$r = $r".put;
    "        \$c = $c".put;

    my Array[Str] @new-matrix = reshape-matrix( @matrix, $r, $c );

    "\nOutput: %s\n".printf: @new-matrix.elems > 0           ??
                             format-matrix_1D( @new-matrix ) !! '0';

    if $VERBOSE && @new-matrix.elems > 1
    {
        "\n%s".printf: format-matrix_2D( @new-matrix, 8 );
    }
}

#==============================================================================
multi sub MAIN()                                 # No input: run the test suite
#==============================================================================
{
    run-tests();
}

#------------------------------------------------------------------------------
sub reshape-matrix
(
    List:D[List:D[Str:D]] $matrix,
    Pos:D                 $r,
    Pos:D                 $c
--> List:D[List:D[Str:D]]
)
#------------------------------------------------------------------------------
{
    my Pos        $orig-size = $matrix.elems * $matrix[ 0 ].elems;
    my Array[Str] @new-matrix;

    if $r * $c == $orig-size
    {
        my Str @list;

        @list.push: |$_ for @$matrix;

        while @list
        {
            my Str @row;

            @row\      .push: @list.shift for 1 .. $c;
            @new-matrix.push: @row;
        }
    }

    return @new-matrix;
}

#------------------------------------------------------------------------------
sub format-matrix_1D( List:D[List:D[Str:D]] $matrix --> Str:D )
#------------------------------------------------------------------------------
{
    my Str  $string  = '[ ';
    my Bool $first   = True;

    for @$matrix -> Array[Str] $row
    {
        if $first
        {
            $first = False;
        }
        else
        {
            $string ~= ', ';
        }

        $string ~= '[ ' ~ $row.join( ', ' ) ~ ' ]';
    }

    $string ~= ' ]';

    return $string;
}

#------------------------------------------------------------------------------
sub format-matrix_2D( List:D[List:D[Str:D]] $matrix, UInt:D $offset --> Str:D )
#------------------------------------------------------------------------------
{
    my Pos  $rows      = $matrix.elems;
    my Pos  $columns   = $matrix[ 0 ].elems;
    my UInt @col-width = 0 xx $columns;

    for 0 .. $rows - 1 -> UInt $i
    {
        for 0 .. $columns - 1 -> UInt $j
        {
            my Pos $width = $matrix[ $i; $j ].chars;

            @col-width[ $j ] = $width if $width > @col-width[ $j ];
        }
    }

    my Str $string;

    for 0 .. $rows - 1 -> UInt $i
    {
        $string ~= ' ' x $offset ~ '[';

        my Str @row = |$matrix[ $i ];

        for 0 .. $columns - 1 -> UInt $j
        {
            $string ~= ' %*s'.sprintf: @col-width[ $j ], @row[ $j ];
        }

        $string ~= " ]\n";
    }

    return $string;
}

#------------------------------------------------------------------------------
sub parse-matrix-string( Str:D $matrix --> List:D[List:D[Str:D]] )
#------------------------------------------------------------------------------
{
    my Str $matrix-str = $matrix;

    $matrix-str ~~ / ^ \s* \[ \s* (.+?) \s* \] \s* $ /
        or error( 'Malformed matrix string' );

    $matrix-str = ~$0;

    my Int        $cols = -1;
    my Array[Str] @matrix;

    {
        my Match $/;
        my UInt  $last-pos;

        while $matrix-str ~~ m:c/ \,? \s* \[ \s* ( <-[\]]>+? ) \s* \] /
        {
            my Str  @row   = $0.split: / [\,\s*|\s+] /;
            my UInt $elems = @row.elems;

            if    $elems == 0
            {
                error( 'Invalid matrix: empty row' );
            }
            elsif $cols  <  0
            {
                $cols = $elems;
            }
            elsif $elems != $cols
            {
                error( 'Malformed matrix: ragged rows' );
            }

            @matrix.push: Array[Str].new: @row;
            $last-pos = $/.pos;
        }

        $matrix-str ~~ m:c( $last-pos )/ (.*) $ /;

        my Str $rest = ~$0;

        $rest ~~ / ^ \s* $ / or error( qq[Malformed matrix string "$rest"] );
    }

    @matrix.elems > 0        or error( 'Empty matrix' );

    return @matrix;
}

#------------------------------------------------------------------------------
sub run-tests()
#------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    my Str @lines = test-data.lines;

    while @lines
    {
        my Str $line = @lines.shift;

        if $line ~~ / \\ $ /
        {
            my Str $next = @lines.shift;

            $line .= chop;
            $line ~= $next;
        }

        my Str ($test-name, $matrix, $r, $c, $expected) = $line.split: / \| /;

        my Array[Str] @old = parse-matrix-string( $matrix );
        my Array[Str] @new = reshape-matrix( @old, $r.Int, $c.Int );
        my Str        $got = @new.elems > 0 ?? format-matrix_1D( @new ) !! '0';

        is $got, $expected, $test-name;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#------------------------------------------------------------------------------
sub test-data( --> Str:D )
#------------------------------------------------------------------------------
{
    return q:to/END/;
        Example 1|[ [ 1, 2 ], [ 3, 4 ] ]        |1|4|[ [ 1, 2, 3, 4 ] ]
        Example 2|[ [ 1, 2, 3 ], [ 4, 5, 6 ] ]  |3|2|[ [ 1, 2 ], [ 3, 4 ], \
        [ 5, 6 ] ]
        Example 3|[ [ 1, 2 ] ]                  |3|2|0
        Letters 1|[[a,b,c][d,e,f][g,h,i][j,k,l]]|3|4|[ [ a, b, c, d ], \
        [ e, f, g, h ], [ i, j, k, l ] ]
        Letters 2|[[a,b,c][d,e,f][g,h,i][j,k,l]]|6|2|[ [ a, b ], [ c, d ], \
        [ e, f ], [ g, h ], [ i, j ], [ k, l ] ]
        Letters 3|[[a,b,c][d,e,f][g,h,i][j,k,l]]|2|6|[ [ a, b, c, d, e, f ], \
        [ g, h, i, j, k, l ] ]
        END
}
###############################################################################
