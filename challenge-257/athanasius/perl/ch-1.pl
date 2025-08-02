#!perl

################################################################################
=comment

Perl Weekly Challenge 257
=========================

TASK #1
-------
*Smaller than Current*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find out how many integers are smaller than current i.e.
foreach ints[i], count ints[j] < ints[i] where i != j.

Example 1

  Input: @ints = (5, 2, 1, 6)
  Output: (2, 1, 0, 3)

  For $ints[0] = 5, there are two integers (2,1) smaller than 5.
  For $ints[1] = 2, there is one integer (1) smaller than 2.
  For $ints[2] = 1, there is none integer smaller than 1.
  For $ints[3] = 6, there are three integers (5,2,1) smaller than 6.

Example 2

  Input: @ints = (1, 2, 0, 3)
  Output: (1, 2, 0, 3)

Example 3

  Input: @ints = (0, 1)
  Output: (0, 1)

Example 4

  Input: @ints = (9, 4, 9, 2)
  Output: (2, 1, 2, 0)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

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

    [<ints> ...]    A non-empty array of integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 257, Task #1: Smaller than Current (Perl)\n\n";
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
        }

        printf "Input: \@ints = (%s)\n", join ', ', @ints;

        my $counts = count_smaller_than_current( \@ints );

        printf "Output:        (%s)\n",  join ', ', @$counts;
    }
}

#-------------------------------------------------------------------------------
sub count_smaller_than_current
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  @counts;

    for my $i (0 .. $#$ints)
    {
        my $count = 0;

        for my $j (0 .. $#$ints)
        {
            next if $i == $j;

            ++$count if $ints->[ $j ] < $ints->[ $i ];
        }

        push @counts, $count;
    }

    return \@counts;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int_str, $exp_str) = split / \| /x, $line;

        for ($test_name, $int_str, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints   = split / \s+ /x, $int_str;
        my @exp    = split / \s+ /x, $exp_str;
        my $counts = count_smaller_than_current( \@ints );

        is_deeply $counts, \@exp, $test_name;
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
Example 1| 5  2  1 6|2 1 0 3
Example 2| 1  2  0 3|1 2 0 3
Example 3| 0  1     |0 1
Example 4| 9  4  9 2|2 1 2 0
Negatives|-2 -2 -1  |0 0 2
