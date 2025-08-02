use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 262
=========================

TASK #1
-------
*Max Positive Negative*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return the maximum number of either positive or negative
integers in the given array.

Example 1

  Input: @ints = (-3, 1, 2, -1, 3, -2, 4)
  Output: 4

  Count of positive integers: 4
  Count of negative integers: 3
  Maximum of count of positive and negative integers: 4

Example 2

  Input: @ints = (-1, -2, -3, 1)
  Output: 3

  Count of positive integers: 1
  Count of negative integers: 3
  Maximum of count of positive and negative integers: 3

Example 3

  Input: @ints = (1,2)
  Output: 2

  Count of positive integers: 2
  Count of negative integers: 0
  Maximum of count of positive and negative integers: 2

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1. Duplicate integers are counted as often as they appear.
   This may be overridden by including the flag "--unique" on the command-line.
2. The number 0 (zero) is positive.
   This may be overridden by including the flag "--skip_0" on the command-line.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. One or more integers are given as arguments on the command-line.
3. If the first integer is negative, it must be preceded by "--" to indicate
   that it is not a command-line flag.
4. If the constant VERBOSE is set to True, the assumptions under which the
   result is calculated are displayed along with the input integers.

=end comment
#===============================================================================

use Test;

my Bool constant VERBOSE = True;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 262, Task #1: Max Positive Negative (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
           *@ints where { .elems > 0 && .all ~~ Int:D },
                                  #= A non-empty list of integers
    Bool:D :$unique = False,      #= Count unique ints only (ignore duplicates)
    Bool:D :$skip_0 = False       #= Consider zero neither positive nor negative
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    if VERBOSE
    {
        "        Count %s\n".printf:
                    $unique ?? 'unique integers only (ignore duplicates)'
                            !! 'all integers, including duplicates';

        "        Consider zero as %s\n".printf:
                    $skip_0 ?? 'neither positive nor negative'
                            !! 'positive';
    }

    my UInt $max = find-max-pos-neg( @ints, $unique, $skip_0 );

    "Output: $max".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-max-pos-neg
(
    List:D[Int:D] $ints,
    Bool:D        $unique,
    Bool:D        $skip_0
--> UInt:D
)
#-------------------------------------------------------------------------------
{
    my UInt $neg-count = 0;
    my UInt $pos-count = 0;
    my Int  @integers  = $unique ?? $ints.unique !! @$ints;

    for @integers -> Int $n
    {
        if    $n < 0
        {
            ++$neg-count;
        }
        elsif $n > 0 || ($n == 0 && !$skip_0)
        {
            ++$pos-count;
        }
    }

    return ($neg-count, $pos-count).max;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expected, $unique, $zero-pos) =
                $line.split: / \| /;

        for     $test-name, $ints-str, $expected, $unique, $zero-pos
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Int  @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt $max  = find-max-pos-neg( @ints, $unique.Bool, $zero-pos.Bool );

        is $max, $expected.Int, $test-name;
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
        Example 1   |-3  1  2 -1 3 -2  4|4| |
        Example 2   |-1 -2 -3  1        |3| |
        Example 3   | 1  2              |2| |
        Duplicates 1| 1 -2  1 -3 2  1 -4|3|1|
        Duplicates 2| 1 -2  1 -3 2  1 -4|4| |
        Zeros 1     | 4  0 -3 -2 1 -4  0|4| |
        Zeros 2     | 4  0 -3 -2 1 -4  0|3| |1
        END
}

################################################################################
