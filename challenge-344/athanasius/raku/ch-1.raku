use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 344
=========================

TASK #1
-------
*Array Form Compute*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints and an integer, $x.

Write a script to add $x to the integer in the array-form.

    The array form of an integer is a digit-by-digit representation stored as an
    array, where the most significant digit is at the 0th index.

Example 1

  Input: @ints = (1, 2, 3, 4), $x = 12
  Output: (1, 2, 4, 6)

Example 2

  Input: @ints = (2, 7, 4), $x = 181
  Output: (4, 5, 5)

Example 3

  Input: @ints = (9, 9, 9), $x = 1
  Output: (1, 0, 0, 0)

Example 4

  Input: @ints = (1, 0, 0, 0, 0), $x = 9999
  Output: (1, 9, 9, 9, 9)

Example 5

  Input: @ints = (0), $x = 1000
  Output: (1, 0, 0, 0)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
----------
1. The integers are all unsigned.
2. An array-form representation should contain no leading (redundant) zeros.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of 2 or more unsigned integers is entered on the command-line. The
   last of these is $x; the rest are single digits and make up @ints.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 344, Task #1: Array Form Compute (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A list of digits followed by an unsigned integer ($x)

    *@ints where { .elems >= 2 && .all ~~ UInt:D }
)
#===============================================================================
{
    my UInt $x = @ints.pop + 0;     # Normalize

    for @ints
    {
        / ^ <[ 0..9 ]> $ / or error( "$_ is not a valid digit" );
    }

    "Input:  \@ints = (%s), \$x = %d\n".printf: @ints.join( ', ' ), $x;

    my UInt @sum = add-array-form( @ints, $x );

    "Output: (%s)\n".printf: @sum.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub add-array-form( List:D[UInt:D] $ints, UInt:D $x --> List:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    my UInt $dim   = ($ints.elems, $x.chars).max + 1;
    my UInt @x-ar  =  $x.split( '', :skip-empty ).map: { .Int };
    my UInt @sum   =  0 xx $dim;
    my UInt $carry =  0;

    @x-ar.unshift: 0 until @x-ar.elems == $dim;
    $ints.unshift: 0 until $ints.elems == $dim;

    for (0 .. @sum.end).reverse -> UInt $i
    {
        my UInt $sum = $ints[$i] + @x-ar[$i] + $carry;

        @sum[$i] = $sum mod 10;
        $carry   = $sum div 10;
    }

    @sum.shift while @sum[0] == 0 && @sum.elems > 1;

    return @sum;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $x-str, $expd-str) = $line.split: / \| /;

        for     $test-name, $ints-str, $x-str, $expd-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt @sum  = add-array-form( @ints, $x-str.Int );
        my UInt @expd = $expd-str.split( / \s+ /, :skip-empty ).map: { .Int };

        is-deeply @sum, @expd, $test-name;
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
        Example 1|1 2 3 4  |  12|1 2 4 6
        Example 2|2 7 4    | 181|4 5 5
        Example 3|9 9 9    |   1|1 0 0 0
        Example 4|1 0 0 0 0|9999|1 9 9 9 9
        Example 5|0        |1000|1 0 0 0
        END
}

################################################################################
