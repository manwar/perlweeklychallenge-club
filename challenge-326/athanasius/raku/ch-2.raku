use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 326
=========================

TASK #2
-------
*Decompressed List*

Submitted by: Mohammad Sajid Anwar

You are given an array of positive integers having even elements.

Write a script to return the decompress[ed] list. To decompress, pick adjacent
pair (i, j) and replace it with j, i times.

Example 1

  Input: @ints = (1, 3, 2, 4)
  Output: (3, 4, 4)

  Pair 1: (1, 3) => 3 one time  => (3)
  Pair 2: (2, 4) => 4 two times => (4, 4)

Example 2

  Input: @ints = (1, 1, 2, 2)
  Output: (1, 2, 2)

  Pair 1: (1, 1) => 1 one time  => (1)
  Pair 2: (2, 2) => 2 two times => (2, 2)

Example 3

  Input: @ints = (3, 1, 3, 2)
  Output: (1, 1, 1, 2, 2, 2)

  Pair 1: (3, 1) => 1 three times => (1, 1, 1)
  Pair 2: (3, 2) => 2 three times => (2, 2, 2)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
"Positive" integers are greater than zero.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty, even-sized list of positive integers is entered on the command-
   line.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 326, Task #2: Decompressed List (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty, even-sized list of positive integers

    *@ints where { .elems > 0 && .elems %% 2 && .all ~~ Pos:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Pos @decompressed = decompress( @ints );

    "Output: (%s)\n".printf:  @decompressed.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub decompress
(
    List:D[Pos:D] $ints where { $ints.elems %% 2 }
--> List:D[Pos:D]
)
#-------------------------------------------------------------------------------
{
    my Pos @decompressed;

    for @$ints -> Pos $count, Pos $elem
    {
        @decompressed.push: |( $elem xx $count );
    }

    return @decompressed;
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

        my Pos @ints   = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Pos @decomp = decompress( @ints );
        my Pos @expctd = $expd-str.split( / \s+ /, :skip-empty ).map: { .Int };

        is-deeply @decomp, @expctd, $test-name;
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
        Example 1|1 3 2 4|3 4 4
        Example 2|1 1 2 2|1 2 2
        Example 3|3 1 3 2|1 1 1 2 2 2
        END
}

################################################################################
