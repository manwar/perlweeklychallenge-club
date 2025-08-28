#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of scores is entered on the command-line.

Assumptions
-----------
During score evaluation, it is an error if a "+" score is not preceded by at
least two other (integer) scores. Likewise, it is an error if a "C" or a "D"
score is not preceded by at least one other (integer) score.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use List::Util     qw( sum0 );
use Regexp::Common qw( number );
use Test::More;
use Try::Tiny;

const my $USAGE => <<END;
Usage:
  perl $0 [<scores> ...]
  perl $0

    [<scores> ...]    A non-empty list of scores (integers, '+', 'C', 'D')
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 336, Task #2: Final Score (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my @scores = @ARGV;

        for (@scores)
        {
            / ^ $RE{num}{int} | [+CD] $ /x
                or error( qq["$_" is not a valid score] );
        }

        printf "Input:  \@scores = (%s)\n", join ',', map { qq["$_"] } @scores;

        try
        {
            my $score = find_final_score( \@scores );

            print "Output: $score\n";
        }
        catch
        {
            print "\nERROR: $_";
        };
    }
}

#-------------------------------------------------------------------------------
sub find_final_score
#-------------------------------------------------------------------------------
{
    my ($scores) = @_;
    my  @queue;

    for my $score (@$scores)
    {
        my $q_len = scalar @queue;

        if    ($score eq '+')
        {
            die qq[Illegal "+" score placement\n] if $q_len < 2;
            push @queue, $queue[ -2 ] + $queue[ -1 ];
        }
        elsif ($score eq 'C')
        {
            die qq[Illegal "C" score placement\n] if $q_len < 1;
            pop  @queue;
        }
        elsif ($score eq 'D')
        {
            die qq[Illegal "D" score placement\n] if $q_len < 1;
            push @queue, 2 * $queue[ -1 ];
        }
        else    # $score must be an integer
        {
            push @queue, $score;
        }
    }

    return sum0 @queue;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $scores_str, $expected) = split / \| /x, $line;

        for ($test_name, $scores_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @scores = split / \s+ /x, $scores_str;
        my $score  = find_final_score( \@scores );

        is $score, $expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1| 5   2 C D +             | 30
Example 2| 5  -2 4 C D 9 + +       | 27
Example 3| 7   D D C + 3           | 45
Example 4|-5 -10 + D C +           |-55
Example 5| 3   6 + D C 8 + D -2 C +|128
