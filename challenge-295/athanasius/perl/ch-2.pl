#!perl

################################################################################
=comment

Perl Weekly Challenge 295
=========================

TASK #2
-------
*Jump Game*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the minimum number of jumps to reach the last element.
$ints[$i] represents the maximum length of a forward jump from the index $i. In
case last element is unreachable then return -1.

Example 1

  Input: @ints = (2, 3, 1, 1, 4)
  Output: 2

  Jump 1 step from index 0 then 3 steps from index 1 to the last element.

Example 2

  Input: @ints = (2, 3, 0, 4)
  Output: 2

Example 3

  Input: @ints = (2, 0, 0, 4)
  Output: -1

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The integers in the input list are unsigned (since a negative length for a for-
ward jump would indicate a backward jump, which is not within the scope of the
Task).

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of unsigned integers is entered on the command-line.

Algorithm
---------
1. Construct array @from, in which each element E contains the index of the
   earliest (i.e., lowest, left-most) element in @$ints from which E can be
   reached by a direct jump.
2. Backtrack from the destination to the origin by following the indices in the
   @from array, counting the jumps.
3. If at any point in the backtrack the current element is undefined (because
   it is unreachable), -1 is returned to indicate failure. Otherwise, when the
   origin is reached, the jump count is returned.

=cut
#===============================================================================

use v5.32;         # Enables strictures and warnings
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of unsigned integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 295, Task #2: Jump Game (Perl)\n\n";
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
            $_ >= 0                or error( "$_ is negative" );
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $min_jumps = find_min_jumps( \@ints );

        print  "Output: $min_jumps\n";
    }
}

#-------------------------------------------------------------------------------
sub find_min_jumps
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;

    # 1. Construct array @from in which each element E contains the index of the
    #    earliest (left-most) element in @$ints from which E can be reached by a
    #    direct jump

    my @from;

    for my $i (0 .. $#$ints)
    {
        for my $j (1 .. $ints->[ $i ])
        {
            my $k = $i + $j;

            last if $k > $#$ints;

            $from[ $k ] = $i unless defined $from[ $k ];
        }
    }

    # 2. Backtrack from the destination to the origin by following the indices
    #    in the @from array

    my $jumps = 0;

    for (my $p = $#$ints; $p > 0; $p = $from[ $p ], ++$jumps)
    {
        return -1 unless defined $from[ $p ];
    }

    return $jumps;
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

        my @ints      = split / \s+ /x, $ints_str;
        my $min_jumps = find_min_jumps( \@ints );

        is $min_jumps, $expected, $test_name;
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
Example 1|2 3 1 1 4| 2
Example 2|2 3 0 4  | 2
Example 3|2 0 0 4  |-1
Singleton|7        | 0
