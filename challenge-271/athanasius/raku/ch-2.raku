use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 271
=========================

TASK #2
-------
*Sort by 1 bits*

Submitted by: Mohammad Sajid Anwar

You are give an array of integers, @ints.

Write a script to sort the integers in ascending order by the number of 1 bits
in their binary representation. In case more than one integers have the same
number of 1 bits then sort them in ascending order.

Example 1

  Input: @ints = (0, 1, 2, 3, 4, 5, 6, 7, 8)
  Output: (0, 1, 2, 4, 8, 3, 5, 6, 7)

  0 = 0 one bits
  1 = 1 one bits
  2 = 1 one bits
  4 = 1 one bits
  8 = 1 one bits
  3 = 2 one bits
  5 = 2 one bits
  6 = 2 one bits
  7 = 3 one bits

Example 2

  Input: @ints = (1024, 512, 256, 128, 64)
  Output: (64, 128, 256, 512, 1024)

  All integers in the given array have one 1-bits, so just sort them in ascend-
  ing order.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
The integers in @int are unsigned (i.e., non-negative).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The elements of @ints are entered in sequence on the command-line.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 271, Task #2: Sort by 1 bits (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| Non-empty list of unsigned integers

    *@ints where { .elems > 0 && .all ~~ UInt:D }
)
#===============================================================================
{
    "Input: \@ints = (%s)\n".printf: @ints.join: ', ';

    my UInt @sorted = sort-by-one-bits( @ints );

    "Output:        (%s)\n"\.printf: @sorted.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub sort-by-one-bits( List:D[UInt:D] $ints --> Seq:D[UInt:D] )
#-------------------------------------------------------------------------------
{
    return $ints.sort: {
                           count-one-bits( $^a ) <=> count-one-bits( $^b ) ||
                                           $^a   <=>   $^b
                       };
}

#-------------------------------------------------------------------------------
sub count-one-bits( UInt:D $decimal --> UInt:D )
#-------------------------------------------------------------------------------
{
    return $decimal.base( 2 ).trans( '0' => '' ).chars;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expd-str) = $line.split: / \| /;

        for     $test-name, $ints-str, $expd-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my UInt @ints   = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt @sorted = sort-by-one-bits( @ints );
        my UInt @expctd = $expd-str.split( / \s+ /, :skip-empty ).map: { .Int };

        is-deeply @sorted, @expctd, $test-name;
    }

    done-testing;
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
        Example 1|0 1 2 3 4 5 6 7 8  |0 1 2 4 8 3 5 6 7
        Example 2|1024 512 256 128 64|64 128 256 512 1024
        END
}

################################################################################
