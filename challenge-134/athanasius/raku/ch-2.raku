use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 134
=========================

TASK #2
-------
*Distinct Terms Count*

Submitted by: Mohammad S Anwar

You are given 2 positive numbers, $m and $n.

Write a script to generate multiplcation table and display count of distinct
terms.

Example 1

 Input: $m = 3, $n = 3
 Output:

       x | 1 2 3
       --+------
       1 | 1 2 3
       2 | 2 4 6
       3 | 3 6 9

 Distinct Terms: 1, 2, 3, 4, 6, 9
 Count: 6

Example 2

 Input: $m = 3, $n = 5
 Output:

       x | 1  2  3  4  5
       --+--------------
       1 | 1  2  3  4  5
       2 | 2  4  6  8 10
       3 | 3  6  9 12 15

 Distinct Terms: 1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15
 Count: 11

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

subset Pos of Int where * > 0;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 134, Task #2: Distinct Terms Count (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Pos:D $m,                     #= Maximum row    number
    Pos:D $n                      #= Maximum column number
)
#==============================================================================
{
    "Input: \$m = $m, \$n = $n".put;

    my Array[Pos] @table;
    my       Pos  %terms;

    for 1 .. $m -> Pos $row
    {
        push @table, Array[Pos].new;

        for 1 .. $n -> Pos $col
        {
            my Pos $product = $row * $col;

            @table[ $row - 1 ].push: $product;

            ++%terms{ $product };
        }
    }

    print-table( $m, $n, @table );

    "\nDistinct Terms: %s\nCount: %d\n".printf:
        %terms.keys.map( { .Int } ).sort.join( ', ' ), %terms.elems;
}

#------------------------------------------------------------------------------
sub print-table
(
    Pos:D                 $m,
    Pos:D                 $n,
    Array:D[Array:D[Pos]] $table
)
#------------------------------------------------------------------------------
{
    my Pos @widths;

    @widths.push: $m.chars;
    @widths.push: .chars for $table[ $m - 1 ].list;

    my UInt $width-sum  = 0;
            $width-sum += $_ for @widths[ 1 .. @widths.end ];

    "\n      %*s |".printf: @widths[ 0 ], 'x';

    ' %*d'.printf: @widths[ $_ ], $_ for 1 .. $n;

    "\n      %s+%s\n".printf: '-' x (@widths[ 0 ] + 1),
                              '-' x ($width-sum   + $n);

    for 1 .. $m -> Pos $row
    {
        '      %*s |'.printf: @widths[ 0 ], $table[ $row - 1; 0 ];

        ' %*d'.printf: @widths[ $_ ], $table[ $row - 1; $_ - 1 ] for 1 .. $n;

        ''.put;
    }
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
