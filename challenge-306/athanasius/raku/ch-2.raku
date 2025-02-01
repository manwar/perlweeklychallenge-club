use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 306
=========================

TASK #2
-------
*Last Element*

Submitted by: Mohammad Sajid Anwar

You are given a array of integers, @ints.

Write a script to play a game where you pick two biggest integers in the given
array, say x and y. Then do the following:

  a) if x == y then remove both from the given array
  b) if x != y then remove x and replace y with (y - x)

At the end of the game, there is at most one element left.

Return the last element if found otherwise return 0.

Example 1

  Input: @ints = (3, 8, 5, 2, 9, 2)
  Output: 1

  Step 1: pick 8 and 9 => (3, 5, 2, 1, 2)
  Step 2: pick 3 and 5 => (2, 2, 1, 2)
  Step 3: pick 2 and 1 => (1, 2, 2)
  Step 4: pick 2 and 1 => (1, 2)
  Step 5: pick 1 and 2 => (1)

Example 2

  Input: @ints = (3, 2, 5)
  Output: 0

  Step 1: pick 3 and 5 => (2, 2)
  Step 2: pick 2 and 2 => ()

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
The input integers are positive (greater than zero).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. One or more positive integers are entered on the command-line.

=end comment
#===============================================================================

use Test;

subset Pos of Int where * > 0;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 306, Task #2: Last Element (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of positive integers

    *@ints where { .elems > 0 && .all ~~ Pos:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my UInt  $last-element = find-last-element( @ints );

    "Output: $last-element".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-last-element( List:D[Pos:D] $ints --> UInt:D )
#-------------------------------------------------------------------------------
{
    my Pos @n = $ints.sort;

    while @n.elems > 1
    {
        my Pos $y = @n.pop;
        my Pos $x = @n.pop;

        if $y > $x
        {
            @n.push: $y - $x;
            @n .= sort;
        }
    }

    return @n.elems == 0 ?? 0 !! @n[ 0 ];
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $ints-str, $expected) =
                $line.split: / \| /;

        for     $test-name, $ints-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Pos  @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt $last = find-last-element( @ints );

        is $last, $expected.Int, $test-name;
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
        Example 1|3 8 5 2 9 2|1
        Example 2|3 2 5      |0
        END
}

################################################################################
