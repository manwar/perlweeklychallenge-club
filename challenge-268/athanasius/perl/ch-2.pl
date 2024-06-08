#!perl

################################################################################
=comment

Perl Weekly Challenge 268
=========================

TASK #2
-------
*Number Game*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, with even number of elements.

Write a script to create a new array made up of elements of the given array.
Pick the two smallest integers and add it to new array in decreasing order i.e.
high to low. Keep doing until the given array is empty.

Example 1

  Input: @ints = (2, 5, 3, 4)
  Output: (3, 2, 5, 4)

  Round 1: we picked (2, 3) and push it to the new array (3, 2)
  Round 2: we picked the remaining (4, 5) and push it to the new array (5, 4)

Example 2

  Input: @ints = (9, 4, 1, 3, 6, 4, 6, 1)
  Output: (1, 1, 4, 3, 6, 4, 9, 6)

Example 3

  Input: @ints = (1, 2, 2, 3)
  Output: (2, 1, 3, 2)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The input integers are entered on the command-line.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty, even-numbered list of integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 268, Task #2: Number Game (Perl)\n\n";
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

        scalar @ints % 2 == 0
            or error( 'The input list has an odd number of elements' );

        for (@ints)
        {
            / ^ $RE{num}{int} $ /x  or error( qq["$_" is not a valid integer] );
        }

        printf "Input: \@ints = (%s)\n", join ', ', @ints;

        my $soln = solve( \@ints );

        printf "Output:        (%s)\n",  join ', ', @$soln;
    }
}

#-------------------------------------------------------------------------------
sub solve
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  @solution;
    my  @sorted = sort { $a <=> $b } @$ints;

    while (@sorted)
    {
        my $first  = shift @sorted;
        my $second = shift @sorted;

        push @solution, $second, $first;
    }

    return \@solution;
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
        my $soln = solve( \@ints );
        my @expd = split / \s+ /x, $expd_str;

        is_deeply $soln, \@expd, $test_name;
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
Example 1|2 5 3 4        |3 2 5 4
Example 2|9 4 1 3 6 4 6 1|1 1 4 3 6 4 9 6
Example 3|1 2 2 3        |2 1 3 2
