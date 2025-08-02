use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 309
=========================

TASK #2
-------
*Min Diff*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the minimum difference between any two elements.

Example 1

  Input: @ints = (1, 5, 8, 9)
  Output: 1

  1, 5 => 5 - 1 => 4
  1, 8 => 8 - 1 => 7
  1, 9 => 9 - 1 => 8
  5, 8 => 8 - 5 => 3
  5, 9 => 9 - 5 => 4
  8, 9 => 9 - 8 => 1

Example 2

  Input: @ints = (9, 4, 1, 7)
  Output: 2

  9, 4 => 9 - 4 => 5
  9, 1 => 9 - 1 => 8
  9, 7 => 9 - 7 => 2
  4, 1 => 4 - 1 => 3
  4, 7 => 7 - 4 => 3
  1, 7 => 7 - 1 => 6

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Differences are absolute values; therefore, the minimum difference is an unsign-
ed integer.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of 2 or more integers is entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to signal that
   it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 309, Task #2: Min Diff (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@ints where { .elems > 1 && .all ~~ Int:D }        #= A list of 2+ integers
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my UInt  $min-diff = find-min-diff( @ints );

    "Output: $min-diff".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-min-diff( List:D[Int:D] $ints where { .elems > 1 } --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt %dict{Int};

    for @$ints -> Int $int
    {
        return 0 if ++%dict{ $int } > 1;
    }

    my Int  @sorted   = %dict.keys.sort: { $^b <=> $^a };
    my UInt $min-diff = @sorted[ 0 ] - @sorted[ 1 ];

    return 1 if $min-diff == 1;

    for 1 .. @sorted.end - 1 -> UInt $i
    {
        my UInt $diff = @sorted[ $i ] - @sorted[ $i + 1 ];

        return 1 if $diff == 1;

        $min-diff = $diff if $diff < $min-diff;
    }

    return $min-diff;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expected) = $line.split: / \| /;

        for     $test-name, $ints-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int  @ints     = $ints-str.split( / \s+ /, :skip-empty )\
                                     .map: { .Int };
        my UInt $min-diff = find-min-diff( @ints );

        is $min-diff, $expected.Int, $test-name;
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
        Example 1| 1  5  8  9   | 1
        Example 2| 9  4  1  7   | 2
        Identical| 4  7  9  4   | 0
        Negatives|-1 -3  7  0 -2| 1
        Big gaps |-5  0 42 13  7| 5
        Pair     |-3 12         |15
        END
}

################################################################################
