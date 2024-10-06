#!perl

################################################################################
=comment

Perl Weekly Challenge 289
=========================

TASK #1
-------
*Third Maximum*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find the third distinct maximum in the given array. If third
maximum doesn't exist then return the maximum number.

Example 1

  Input: @ints = (5, 6, 4, 1)
  Output: 4

  The first distinct maximum is 6.
  The second distinct maximum is 5.
  The third distinct maximum is 4.

Example 2

  Input: @ints = (4, 5)
  Output: 5

  In the given array, the third maximum doesn't exist therefore returns the
  maximum.

Example 3

  Input: @ints =  (1, 2, 2, 3)
  Output: 1

  The first distinct maximum is 3.
  The second distinct maximum is 2.
  The third distinct maximum is 1.

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
2. A non-empty list of integers is entered on the command-line.

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

    [<ints> ...]    A non-empty list of integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 289, Task #1: Third Maximum (Perl)\n\n";
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
           / ^ $RE{num}{int} $ /x   or error( qq["$_" is not a valid integer] );
           $_ += 0;     # Normalize
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $third_max = find_third_max( \@ints );

        print "Output: $third_max\n";
    }
}

#-------------------------------------------------------------------------------
sub find_third_max
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  %count;
      ++$count{ $_ } for @$ints;

    my @sorted = sort { $b <=> $a } keys %count;
    my $index  = scalar @sorted >= 3 ? 2 : 0;

    return $sorted[ $index ];
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
        my $third_max = find_third_max( \@ints );

        is $third_max, $expected, $test_name;
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
Example 1| 5 6 4 1| 4
Example 2| 4 5    | 5
Example 3| 1 2 2 3| 1
Singleton|42      |42
