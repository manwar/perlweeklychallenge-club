use v6d;

################################################################################
=begin comment

Perl Weekly Challenge 336
=========================

TASK #2
-------
*Final Score*

Submitted by: Mohammad Sajid Anwar

You are given an array of scores by a team.

Write a script to find the total score of the given team. The score can be any
integer, +, C or D. The + adds the sum of previous two scores. The score C
invalidates the previous score. The score D will double the previous score.

Example 1

  Input: @scores = ("5","2","C","D","+")
  Output: 30

  Round 1: 5
  Round 2: 5 + 2
  Round 3: 5 (invalidate the previous score 2)
  Round 4: 5 + 10 (double the previous score 5)
  Round 5: 5 + 10 + 15 (sum of previous two scores)

  Total Scores: 30

Example 2

  Input: @scores = ("5","-2","4","C","D","9","+","+")
  Output: 27

  Round 1: 5
  Round 2: 5 + (-2)
  Round 3: 5 + (-2) + 4
  Round 4: 5 + (-2) (invalidate the previous score 4)
  Round 5: 5 + (-2) + (-4) (double the previous score -2)
  Round 6: 5 + (-2) + (-4) + 9
  Round 7: 5 + (-2) + (-4) + 9 + 5 (sum of previous two scores)
  Round 8: 5 + (-2) + (-4) + 9 + 5 + 14 (sum of previous two scores)

  Total Scores: 27

Example 3

  Input: @scores = ("7","D","D","C","+","3")
  Output: 45

  Round 1: 7
  Round 2: 7 + 14 (double the previous score 7)
  Round 3: 7 + 14 + 28 (double the previous score 14)
  Round 4: 7 + 14 (invalidate the previous score 28)
  Round 5: 7 + 14 + 21 (sum of previous two scores)
  Round 6: 7 + 14 + 21 + 3

  Total Scores: 45

Example 4

  Input: @scores = ("-5","-10","+","D","C","+")
  Output: -55

  Round 1: (-5)
  Round 2: (-5) + (-10)
  Round 3: (-5) + (-10) + (-15) (sum of previous two scores)
  Round 4: (-5) + (-10) + (-15) + (-30) (double the previous score -15)
  Round 5: (-5) + (-10) + (-15) (invalidate the previous score -30)
  Round 6: (-5) + (-10) + (-15) + (-25) (sum of previous two scores)

  Total Scores: -55

Example 5

  Input: @scores = ("3","6","+","D","C","8","+","D","-2","C","+")
  Output: 128

  Round  1: 3
  Round  2: 3 + 6
  Round  3: 3 + 6 + 9 (sum of previous two scores)
  Round  4: 3 + 6 + 9 + 18 (double the previous score 9)
  Round  5: 3 + 6 + 9 (invalidate the previous score 18)
  Round  6: 3 + 6 + 9 + 8
  Round  7: 3 + 6 + 9 + 8 + 17 (sum of previous two scores)
  Round  8: 3 + 6 + 9 + 8 + 17 + 34 (double the previous score 17)
  Round  9: 3 + 6 + 9 + 8 + 17 + 34 + (-2)
  Round 10: 3 + 6 + 9 + 8 + 17 + 34 (invalidate the previous score -2)
  Round 11: 3 + 6 + 9 + 8 + 17 + 34 + 51 (sum of previous two scores)

  Total Scores: 128

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
2. A non-empty list of scores is entered on the command-line.
3. If the first score is a negative integer, it must be preceded by "--" to
   signal that it is not a command-line flag.

Assumptions
-----------
During score evaluation, it is an error if a "+" score is not preceded by at
least two other (integer) scores. Likewise, it is an error if a "C" or a "D"
score is not preceded by at least one other (integer) score.

=end comment
#===============================================================================

use Test;

subset Score where * ~~ Int:D | '+' | 'C' | 'D';

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 336, Task #2: Final Score (Raku)\n".put;
}

#===============================================================================
multi sub MAIN
(
    #| A non-empty list of scores (integers, '+', 'C', 'D')

    *@scores where { .elems > 0 && .all ~~ Score:D }
)
#===============================================================================
{
    CATCH
    {
        when X::AdHoc
        {
            "\nERROR: { .message }".put;
            exit 0;
        }
    }

    "Input:  @scores = (%s)\n".printf: @scores.map( { qq["$_"] } ).join: ',';

    my Int $score = find-final-score( @scores );

    "Output: $score".put;
}

#===============================================================================
multi sub MAIN()                                  # No input: run the test suite
#===============================================================================
{
    run-tests();
}

#-------------------------------------------------------------------------------
sub find-final-score( List:D[Score:D] $scores --> Int:D )
#-------------------------------------------------------------------------------
{
    my Score @queue;

    for @$scores -> Score $score
    {
        my UInt $q-len = @queue.elems;

        given $score
        {
            when '+' {
                         die qq[Illegal "+" score placement] if 2 > $q-len;
                         @queue.push: [+] @queue[ *-2 .. *-1 ];
                     }

            when 'C' {
                         die qq[Illegal "C" score placement] if 1 > $q-len;
                         @queue.pop;
                     }

            when 'D' {
                         die qq[Illegal "D" score placement] if 1 > $q-len;
                         @queue.push: 2 * @queue[ *-1 ];
                     }

            default  {                               # $score must be an integer
                         @queue.push: $score;
                     }
        }
    }

    return [+] @queue;
}

#-------------------------------------------------------------------------------
sub run-tests()
#-------------------------------------------------------------------------------
{
    'Running the test suite'.put;

    for test-data.lines -> Str $line
    {
        my Str ($test-name, $scores-str, $expected) = $line.split: / \| /;

        for     $test-name, $scores-str, $expected
        {
            s/ ^ \s+   //;
            s/   \s+ $ //;
        }

        my Str   @strings = $scores-str.split: / \s+ /, :skip-empty;
        my Score @scores  = @strings.map: { / ^ <[+CD]> $ / ?? $_ !! .Int };
        my Int   $score   = find-final-score( @scores );

        is $score, $expected.Int, $test-name;
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
        Example 1| 5   2 C D +             | 30
        Example 2| 5  -2 4 C D 9 + +       | 27
        Example 3| 7   D D C + 3           | 45
        Example 4|-5 -10 + D C +           |-55
        Example 5| 3   6 + D C 8 + D -2 C +|128
        END
}

################################################################################
