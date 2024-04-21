use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 265
=========================

TASK #1
-------
*33% Appearance*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find an integer in the given array that appeared 33% or more.
If more than one found, return the smallest. If none found then return undef.

Example 1

  Input: @ints = (1,2,3,3,3,3,4,2)
  Output: 3

  1 appeared 1 times.
  2 appeared 2 times.
  3 appeared 4 times.

  3 appeared 50% (>33%) in the given array.

Example 2

  Input: @ints = (1,1)
  Output: 1

  1 appeared 2 times.

  1 appeared 100% (>33%) in the given array.

Example 3

  Input: @ints = (1,2,3)
  Output: 1

  1 appeared 1 times.
  2 appeared 1 times.
  3 appeared 1 times.

  Since all three appeared 33.3% (>33%) in the given array.
  We pick the smallest of all.

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
2. A list of one or more integers is given on the command-line.
3. If the first integer is negative, it must be preceded by "--" to indicate
   that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

my Rat constant THRESHOLD = 0.33;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 265, Task #1: 33% Appearance (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers

    *@ints where { .elems > 0 && .all ~~ Int:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ',';

    my Int $solution = solve( @ints );

    "Output: %s\n".printf: $solution.defined ?? $solution !! 'undef (= none)';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub solve( List:D[Int:D] $ints --> Int )
#-------------------------------------------------------------------------------
{
    my UInt $target = ($ints.elems * THRESHOLD).ceiling;
    my Int  %count;
          ++%count{ $_ } for @$ints;
    my Int  @candidates = %count<>:k.grep( { %count{ $_ } >= $target } )\
                                    .map: { .Int };

    return  @candidates.elems > 0 ?? @candidates.min !! Int;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expected-str) = $line.split: / \| /;

        for     $test-name, $ints-str, $expected-str
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int @ints     = $ints-str.split( / \s+ /, :skip-empty )\
                                    .map: { .Int };
        my Int $solution = solve( @ints );
        my Int $expected = $expected-str.chars > 0 ?? $expected-str.Int !! Int;

        is $solution, $expected, $test-name;
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
        Example 1| 1 2  3 3  3  3 4 2| 3
        Example 2| 1 1               | 1
        Example 3| 1 2  3            | 1
        None     | 1 2  3 4          |
        Negatives|-1 0 -2 1 -2 -1    |-2
        END
}

################################################################################
