use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 303
=========================

TASK #2
-------
*Delete and Earn*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to return the maximum number of points you can earn by applying
the following operation some number of times.

  Pick any ints[i] and delete it to earn ints[i] points.
  Afterwards, you must delete every element equal to ints[i] - 1
  and every element equal to ints[i] + 1.

Example 1

  Input: @ints = (3, 4, 2)
  Output: 6

  Delete 4 to earn 4 points, consequently, 3 is also deleted.
  Finally delete 2 to earn 2 points.

Example 2

  Input: @ints = (2, 2, 3, 3, 3, 4)
  Output: 9

  Delete a 3 to earn 3 points. All 2's and 4's are also deleted too.
  Delete a 3 again to earn 3 points.
  Delete a 3 once more to earn 3 points.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumption
----------
Negative and zero values are allowed in @ints, but they will be (effectively)
ignored as they cannot be used to augment the points total.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.
3. If the first integer is negative, it must be preceded by "--" to signal that
   it is not a command-line flag.

=end comment
#===============================================================================

use Test;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 303, Task #2: Delete and Earn (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    *@ints where { .elems > 0 && .all ~~ Int:D } #= A non-empty list of integers
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my UInt $max = find-max-points( @ints );

    "Output: $max".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-max-points( List:D[Int:D] $ints --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt $max-points = 0;
    my Int  @sorted     = $ints.sort;
    my Int  $max-int    = @sorted[ *-1 ];

    recurse( @sorted, 0, $max-points ) if $max-int > 0;

    return $max-points;
}

#-------------------------------------------------------------------------------
sub recurse( List:D[Int:D] $ints, UInt:D $points, UInt:D $max-points is rw )
#-------------------------------------------------------------------------------
{
    if $ints.elems > 0
    {
        my Int $max-int = $ints[ *-1 ];

        if $max-int > 0
        {
            my Int @first = $ints.grep: { $_ != $max-int - 1 };
            @first.pop;

            recurse( @first, $points + $max-int, $max-points );

            if $max-int > 1 && $max-int - 1 == $ints.any
            {
                my Int @second = $ints.grep: { $_ != $max-int &&
                                               $_ != $max-int - 2 };
                @second.pop;

                recurse( @second, $points + $max-int - 1, $max-points );
            }
        }
    }

    $max-points = ($points, $max-points).max;
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

        my Int  @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my UInt $max  = find-max-points( @ints );

        is $max, $expected.Int, $test-name;
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
        Example 1   |3 4 2              | 6
        Example 2   |2 2 3 3 3 4        | 9
        Second/first|2 0 6 3 7 4 7 6 6 0|24
        END
}

################################################################################
