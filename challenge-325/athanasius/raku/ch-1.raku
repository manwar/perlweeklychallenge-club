use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 325
=========================

TASK #1
-------
*Consecutive One*

Submitted by: Mohammad Sajid Anwar

You are given a binary array containing only 0 or/and 1.

Write a script to find out the maximum consecutive 1 in the given array.

Example 1

  Input: @binary = (0, 1, 1, 0, 1, 1, 1)
  Output: 3

Example 2

  Input: @binary = (0, 0, 0, 0)
  Output: 0

Example 3

  Input: @binary = (1, 0, 1, 0, 1, 1)
  Output: 2

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of binary digits is entered on the command-line.

=end comment
#===============================================================================

use Test;

subset BinDigit of Int where 0 | 1;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 325, Task #1: Consecutive One (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of binary digits

    *@binary where { .elems > 0 && .all ~~ BinDigit:D }
)
#===============================================================================
{
    "Input:  \@binary = (%s)\n".printf: @binary.join: ', ';

    my UInt $max-ones = find-max-ones( @binary );

    "Output: $max-ones".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-max-ones( List:D[BinDigit:D] $binary --> UInt:D )
#-------------------------------------------------------------------------------
{
    my Str $string = $binary.join;
    my Str @groups = $string.split: '0', :skip-empty;
    my Str @sorted = @groups.sort;

    return @sorted.elems == 0 ?? 0 !! @sorted[ *-1 ].chars;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $binary-str, $expected) = $line.split: / \| /;

        for     $test-name, $binary-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my BinDigit @binary   = $binary-str\ .split( / \s+ /, :skip-empty )
                                             .map: { .Int };
        my UInt     $max-ones = find-max-ones( @binary );

        is $max-ones, $expected.Int, $test-name;
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
        Example 1|0 1 1 0 1 1 1|3
        Example 2|0 0 0 0      |0
        Example 3|1 0 1 0 1 1  |2
        END
}

################################################################################
