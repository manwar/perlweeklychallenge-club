use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 345
=========================

TASK #2
-------
*Last Visitor*

Submitted by: Mohammad Sajid Anwar

You are given an integer array @ints where each element is either a positive
integer or -1.

We process the array from left to right while maintaining two lists:

  @seen: stores previously seen positive integers (newest at the front)
  @ans: stores the answers for each -1

Rules:

  If $ints[i] is a positive number -> insert it at the front of @seen
  If $ints[i] is -1:

Let $x be how many -1s in a row we've seen before this one.

If $x < len(@seen) -> append seen[x] to @ans

Else -> append -1 to @ans

At the end, return @ans.

Example 1

  Input: @ints = (5, -1, -1)
  Output: (5, -1)

  @seen = (5)
  First  -1: @ans = (5)
  Second -1: @ans = (5, -1)

Example 2

  Input: @ints = (3, 7, -1, -1, -1)
  Output: (7, 3, -1)

  @seen = (3, 7)
  First  -1: @ans = (7)
  Second -1: @ans = (7, 3)
  Third  -1: @ans = (7, 3, -1)

Example 3

  Input: @ints = (2, -1, 4, -1, -1)
  Output: (2, 4, 2)

Example 4

  Input: @ints = (10, 20, -1, 30, -1, -1)
  Output: (20, 30, 20)

Example 5

  Input: @ints = (-1, -1, 5, -1)
  Output: (-1, -1, 5)

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Assumptions
-----------
1.  A "positive integer" is any non-negative integer (i.e., including zero).
    Hence, the allowed values in @ints are integers in the range: -1, 0, 1, ...
2. "Let $x be how many -1s in a row we've seen before this one." should read:
   "Let $x be how many -1s in a row we've seen *immediately* before this one."

Interface
---------
1.  If no command-line arguments are given, the test suite is run. Otherwise:
2.  A non-empty list of integers is entered on the command-line; each integer is
    greater than or equal to -1.
3.  If the first such integer is -1, it must be preceded by "--" to signal that
    it is not a command-line flag.

=end comment
#===============================================================================

use Test;

subset Type of Int where * >= -1;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 345, Task #2: Last Visitor (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of integers, each -1 or greater

    *@ints where { .elems > 0 && .all ~~ Type:D }
)
#===============================================================================
{
    "Input:  \@ints = (%s)\n".printf: @ints.join: ', ';

    my Type @ans = find-answers( @ints );

    "Output: (%s)\n".printf: @ans.join: ', ';
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-answers( List:D[Type:D] $ints --> List:D[Type:D] )
#-------------------------------------------------------------------------------
{
    my UInt @seen;
    my Type @ans;
    my UInt $x = 0;

    for @$ints -> Type $n
    {
        if $n >= 0
        {
            @seen.unshift: $n;
            $x = 0;
        }
        else
        {
            @ans.push: (@seen.elems > $x) ?? @seen[$x] !! -1;
            ++$x;
        }
    }

    return @ans;
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

        my Type @ints = $ints-str.split( / \s+ /, :skip-empty ).map: { .Int };
        my Type @ans  = find-answers( @ints );
        my Type @expd = $expd-str.split( / \s+ /, :skip-empty ).map: { .Int };

        is-deeply @ans, @expd, $test-name;
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
        Example 1| 5 -1 -1         | 5 -1
        Example 2| 3  7 -1 -1 -1   | 7  3 -1
        Example 3| 2 -1  4 -1 -1   | 2  4  2
        Example 4|10 20 -1 30 -1 -1|20 30 20
        Example 5|-1 -1  5 -1      |-1 -1  5
        END
}

################################################################################
