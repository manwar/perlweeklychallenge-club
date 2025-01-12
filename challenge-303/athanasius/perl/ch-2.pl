#!perl

################################################################################
=comment

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

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Negative and zero values are allowed in @ints, but they will be (effectively)
ignored as they cannot be used to augment the points total.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures and warnings
use Const::Fast;
use List::Util     qw( any max );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 303, Task #2: Delete and Earn (Perl)\n\n";
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

        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
            for @ints;

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $max = find_max_points( \@ints );

        print  "Output: $max\n";
    }
}

#-------------------------------------------------------------------------------
sub find_max_points
#-------------------------------------------------------------------------------
{
    my ($ints)      = @_;
    my  $max_points = 0;
    my  @sorted     = sort { $a <=> $b } @$ints;
    my  $max_int    = $sorted[ -1 ];

    recurse( \@sorted, 0, \$max_points ) if $max_int > 0;

    return $max_points;
}

#-------------------------------------------------------------------------------
sub recurse
#-------------------------------------------------------------------------------
{
    my ($ints, $points, $max_points) = @_;

    if (@$ints)
    {
        my  $max_int = $ints->[ -1 ];

        if ($max_int > 0)
        {
            my  @first = grep { $_ != $max_int - 1 } @$ints;
            pop @first;

            recurse( \@first, $points + $max_int, $max_points );

            if ($max_int > 1 && any { $_ == $max_int - 1 } @$ints)
            {
                my  @second =  grep { $_ != $max_int       &&
                                      $_ != $max_int - 2 } @$ints;
                pop @second;

                recurse( \@second, $points + $max_int - 1, $max_points );
            }
        }
    }

    $$max_points = max $points, $$max_points;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $expected) = split / \| /x, $line;

        for ($test_name, $ints_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints = split / \s+ /x, $ints_str;
        my $max  = find_max_points( \@ints );

        is $max, $expected, $test_name;
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
Example 1   |3 4 2              | 6
Example 2   |2 2 3 3 3 4        | 9
Second/first|2 0 6 3 7 4 7 6 6 0|24
