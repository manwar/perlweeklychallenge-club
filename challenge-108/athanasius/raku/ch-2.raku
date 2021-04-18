use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 108
=========================

TASK #2
-------
*Bell Numbers*

Submitted by: Mohammad S Anwar

Write a script to display top 10 *Bell Numbers*. Please refer to
[ https://en.wikipedia.org/wiki/Bell_number |wikipedia page] for more informa-
tions.

Example:

B0: 1 as you can only have one partition of zero element set
B1: 1 as you can only have one partition of one element set {a}.
B2: 2
       {a}{b}
       {a,b}
B3: 5
       {a}{b}{c}
       {a,b}{c}
       {a}{b,c}
       {a,c}{b}
       {a,b,c}
B4: 15
       {a}{b}{c}{d}
       {a,b,c,d}
       {a,b}{c,d}
       {a,c}{b,d}
       {a,d}{b,c}
       {a,b}{c}{d}
       {a,c}{b}{d}
       {a,d}{b}{c}
       {b,c}{a}{d}
       {b,d}{a}{c}
       {c,d}{a}{b}
       {a}{b,c,d}
       {b}{a,c,d}
       {c}{a,b,d}
       {d}{a,b,c}

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2021 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Algorithm
---------
From OEIS A000110: Bell or exponential numbers...

"Triangle (addition) scheme to produce terms, derived from the recurrence, from
Oscar Arevalo (loarevalo(AT)sbcglobal.net), May 11 2005:
    1
    1  2
    2  3  5
    5  7 10 15
   15 20 27 37 52
   ..."

(1) The first row contains the number 1 only
(2) The first number of each new row is the last number of the previous row
(3) The remaining numbers in the row are calculated as follows:
        entry[i][j] = entry[i][j-1] + entry[i-1][j-1]
    where i is the row number and j is the column number

Command Line Argument
---------------------
Although the Task is to display the "top 10 Bell Numbers" -- which I interpret
to mean the *first* 10 Bell Numbers -- the implementation below allows the user
to (optionally) specify the number of Bell Numbers to calculate. If no number
is provided, it defaults to 10.

Note on "use bigint"
--------------------
This pragma is included to facilitate the calculation of a larger number of
Bell Numbers than the 10 required for the Task. Its inclusion does not appreci-
ably impact performance.

=end comment
#==============================================================================

my UInt constant $TARGET = 10;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 108, Task #2: Bell Numbers (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    #| How many Bell numbers are to be displayed?

    UInt:D $target where { $target > 0 } = $TARGET;
)
#==============================================================================
{
    my UInt        $row = 0;
    my Array[UInt] @triangle;

    @triangle.push: Array[UInt].new( 1 );

    if $target == 1
    {
        "The first Bell number:\n    B0: %d\n".printf: @triangle[0][0];
    }
    else
    {
        for 2 .. $target - 1
        {
            @triangle[$row + 1] = Array[UInt].new( @triangle[$row][$row] );

            for 1 .. ++$row -> UInt $col
            {
                @triangle[$row].push: @triangle[$row    ][$col - 1] +
                                      @triangle[$row - 1][$col - 1];
            }
        }

        my UInt @bell;

        @bell.push: @triangle[$_ ][ 0 ] for 0 .. @triangle.end;
        @bell.push: @triangle[*-1][*-1];

        "The first $target Bell numbers:".put;

        my UInt $i-width = ($target - 1).chars;

        for 0 .. $target - 1 -> UInt $i
        {
            ( "    B$i: " ~ ' ' x ($i-width - $i.chars) ~ @bell[$i] ).put;
        }
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
