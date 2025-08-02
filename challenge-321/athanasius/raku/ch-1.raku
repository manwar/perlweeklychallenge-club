use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 321
=========================

TASK #1
-------
*Distinct Average*

Submitted by: Mohammad Sajid Anwar

You are given an array of numbers with even length.

Write a script to return the count of distinct average. The average is calculate
by removing the minimum and the maximum, then average of the two.

Example 1

  Input: @nums = (1, 2, 4, 3, 5, 6)
  Output: 1

  Step 1: Min = 1, Max = 6, Avg = 3.5
  Step 2: Min = 2, Max = 5, Avg = 3.5
  Step 3: Min = 3, Max = 4, Avg = 3.5

  The count of distinct average is 1.

Example 2

  Input: @nums = (0, 2, 4, 8, 3, 5)
  Output: 2

  Step 1: Min = 0, Max = 8, Avg = 4
  Step 2: Min = 2, Max = 5, Avg = 3.5
  Step 3: Min = 3, Max = 4, Avg = 3.5

  The count of distinct average is 2.

Example 3

  Input: @nums = (7, 3, 1, 0, 5, 9)
  Output: 2

  Step 1: Min = 0, Max = 9, Avg = 4.5
  Step 2: Min = 1, Max = 7, Avg = 4
  Step 3: Min = 3, Max = 5, Avg = 4

  The count of distinct average is 2.

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
2. A non-empty, even-sized list of numbers is entered on the command-line.
3. If the first list element is negative, it must preceded by "--" to indicate
   that it is not a command-line flag.

=end comment
#===============================================================================

use Test;

my Bool constant DEBUG = False;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 321, Task #1: Distinct Average (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty, even-sized list of numbers

    *@nums where { .elems > 0 && .elems %% 2 && .all ~~ Real:D }
)
#===============================================================================
{
    my Rat @rats = @nums.map: { .Rat };

    "Raw input: %s\n".printf: @rats.raku if DEBUG;

    "Input:  \@nums = (%s)\n".printf: @rats.join: ', ';

    my UInt $count = count-distinct-avgs( @rats );

    "Output: $count".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub count-distinct-avgs( List:D[Rat:D] $nums where { .elems %% 2 } --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt %distinct-avgs{Rat};
    my Rat  @sorted = $nums.sort;

    while @sorted.elems >= 2
    {
        my Rat $min = @sorted.shift;
        my Rat $max = @sorted.pop;
        my Rat $avg = ($min + $max) / 2;

        ++%distinct-avgs{ $avg };
    }

    "Distinct averages: %s\n".printf: %distinct-avgs.raku if DEBUG;

    return %distinct-avgs.keys.elems;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $nums-str, $expected) = $line.split: / \| /;

        for     $test-name, $nums-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Rat  @nums  = $nums-str.split( / \s+ /, :skip-empty ).map: { .Rat };
        my UInt $count = count-distinct-avgs( @nums );

        is $count, $expected.Int, $test-name;
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
        Example 1|1 2 4 3 5 6|1
        Example 2|0 2 4 8 3 5|2
        Example 3|7 3 1 0 5 9|2
        END
}

################################################################################
