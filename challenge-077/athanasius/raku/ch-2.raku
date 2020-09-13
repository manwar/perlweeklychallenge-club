use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 077
=========================

Task #2
-------
*Lonely X*

Submitted by: Mohammad S Anwar

You are given m x n character matrix consists of O and X only.

Write a script to count the total number of X surrounded by O only. Print 0 if
none found.

Example 1:

 Input: [ O O X ]
        [ X O O ]
        [ X O O ]

 Output: 1 as there is only one X at the first row last column surrounded by
 only O.

Example 2:

 Input: [ O O X O ]
        [ X O O O ]
        [ X O O X ]
        [ O X O O ]

 Output: 2

     a) First  X found at Row 1 Col 3.

     b) Second X found at Row 3 Col 4.

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 077, Task #2: Lonely X (Raku)\n".put;
}

##=============================================================================
sub MAIN
(
    *@rows where { @rows   .elems > 0 &&         #= 1+ same-width rows, each a
                   @rows[0].chars > 0 }          #= string of 'O' and 'X' chars
)
##=============================================================================
{
    my Str        @str-rows = @rows;
    my Array[Str] @matrix   = get-matrix(@str-rows);
    print-matrix( @matrix );

    my Pair @lonely-X = find-lonely-X(@matrix);
    my UInt $count    = @lonely-X.elems;

    " Output: %d\n%s".printf: $count, $count ?? "\n" !! '';

    my UInt $i = 0;
    "   %d. Lonely X found at Row %d Col %d\n".printf: ++$i, .kv for @lonely-X;
}

#------------------------------------------------------------------------------
sub find-lonely-X( Array:D[Str:D] @matrix --> Array:D[Pair:D] )
#------------------------------------------------------------------------------
{
    my Pair @lonely-X;
    my UInt $max-row = @matrix.end;
    my UInt $max-col = @matrix[0].elems - 1;

    for 0 .. $max-row -> UInt $row
    {
        COLUMN: for 0 .. $max-col -> UInt $col
        {
            if @matrix[$row; $col] eq 'X'
            {
                for -1, 0, 1 -> Int $row-delta
                {
                    my Int  $neighbour-row = $row + $row-delta;
                    next if $neighbour-row < 0 ||
                            $neighbour-row > $max-row;

                    for -1, 0, 1 -> Int $col-delta
                    {
                        next if $row-delta == 0 &&
                                $col-delta == 0;         # Self, not neighbour!

                        my Int  $neighbour-col = $col + $col-delta;
                        next if $neighbour-col < 0 ||
                                $neighbour-col > $max-col;

                        next COLUMN                      # This X is not lonely
                             if @matrix[$neighbour-row; $neighbour-col] eq 'X';
                    }
                }

                push @lonely-X, Pair.new($row + 1, $col + 1);      # A lonely X
            }
        }
    }

    return @lonely-X;
}

#------------------------------------------------------------------------------
sub get-matrix( Str:D @rows --> Array:D[Str:D] )
#------------------------------------------------------------------------------
{
    my UInt       $width = @rows[0].chars;
    my Array[Str] @matrix[ @rows.elems ];

    for 0 .. @rows.end -> UInt $i
    {
        my Str $row = @rows[$i];

        $row ~~ / ( <-[ O X ]> ) /
            and error("Invalid character '$0' in the input matrix");

        $row.chars == $width
            or  error("Inconsistent number of columns in row { $i + 1 }");

        my Str @chars = $row.split: '', :skip-empty;
        @matrix[$i]   = @chars;
    }

    return @matrix;
}

#------------------------------------------------------------------------------
sub print-matrix( Array:D[Str:D] @matrix )
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
