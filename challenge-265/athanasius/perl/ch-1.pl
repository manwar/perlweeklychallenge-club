#!perl

################################################################################
=comment

Perl Weekly Challenge 265
=========================

TASK #1
-------
*33% Appearance*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find an integer in the given array that appeared 33% or more.
If more than one found, return the smallest. If none found then return undef.

Example 1

  Input: @ints = (1,2,3,3,3,3,4,2)
  Output: 3

  1 appeared 1 times.
  2 appeared 2 times.
  3 appeared 4 times.

  3 appeared 50% (>33%) in the given array.

Example 2

  Input: @ints = (1,1)
  Output: 1

  1 appeared 2 times.

  1 appeared 100% (>33%) in the given array.

Example 3

  Input: @ints = (1,2,3)
  Output: 1

  1 appeared 1 times.
  2 appeared 1 times.
  3 appeared 1 times.

  Since all three appeared 33.3% (>33%) in the given array.
  We pick the smallest of all.

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
2. A list of one or more integers is given on the command-line.

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use List::Util     qw( min );
use POSIX          qw( ceil );
use Regexp::Common qw( number );
use Test::More;

const my $THRESHOLD => 0.33;
const my $USAGE     => <<END;
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
    print "\nChallenge 265, Task #1: 33% Appearance (Perl)\n\n";
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

        printf "Input:  \@ints = (%s)\n", join ',', @ints;

        my $solution = solve( \@ints );

        printf "Output: %s\n", defined $solution ? $solution : 'undef (= none)';
    }
}

#-------------------------------------------------------------------------------
sub solve
#-------------------------------------------------------------------------------
{
    my ($ints)  = @_;
    my  $target = ceil( scalar( @$ints ) * $THRESHOLD );
    my  %count;
      ++$count{ $_ } for @$ints;
    my  @candidates = grep { $count{ $_ } >= $target } keys %count;

    return scalar @candidates > 0 ? min( @candidates ) : undef;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $expected_str) = split / \| /x, $line;

        for ($test_name, $ints_str, $expected_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints     = split / \s+ /x, $ints_str;
        my $solution = solve( \@ints );
        my $expected = length $expected_str > 0 ? $expected_str : undef;

        is $solution, $expected, $test_name;
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
Example 1| 1 2  3 3  3  3 4 2| 3
Example 2| 1 1               | 1
Example 3| 1 2  3            | 1
None     | 1 2  3 4          |
Negatives|-1 0 -2 1 -2 -1    |-2
