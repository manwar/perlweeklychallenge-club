#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

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

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of integers, each -1 or greater
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 345, Task #2: Last Visitor (Perl)\n\n";
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
        my @ints = @ARGV;

        for (@ints)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
            $_ >= -1               or error( qq["$_" is too small]);
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $ans = find_answers( \@ints );

        printf "Output: (%s)\n", join ', ', @$ans;
    }
}

#-------------------------------------------------------------------------------
sub find_answers
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my (@seen, @ans);
    my  $x     = 0;

    for my $n (@$ints)
    {
        if ($n >= 0)
        {
            unshift @seen, $n;
            $x = 0;
        }
        else
        {
            push @ans, (scalar @seen > $x) ? $seen[$x] : -1;
            ++$x;
        }
    }

    return \@ans;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $expd_str) = split / \| /x, $line;

        for ($test_name, $ints_str, $expd_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints = split / \s+ /x, $ints_str;
        my $ans  = find_answers( \@ints );
        my @expd = split / \s+ /x, $expd_str;

        is_deeply $ans, \@expd, $test_name;
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
Example 1| 5 -1 -1         | 5 -1
Example 2| 3  7 -1 -1 -1   | 7  3 -1
Example 3| 2 -1  4 -1 -1   | 2  4  2
Example 4|10 20 -1 30 -1 -1|20 30 20
Example 5|-1 -1  5 -1      |-1 -1  5
