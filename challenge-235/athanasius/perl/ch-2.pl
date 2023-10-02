#!perl

################################################################################
=comment

Perl Weekly Challenge 235
=========================

TASK #2
-------
*Duplicate Zeros*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to duplicate each occurrence of ZERO in the given array and shift
the remaining to the right but make sure the size of array remain the same.

Example 1

  Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
  Output: (1, 0, 0, 2, 3, 0, 0, 4)

Example 2

  Input: @ints = (1, 2, 3)
  Output: (1, 2, 3)

Example 3

  Input: @ints = (0, 3, 0, 4, 5)
  Output: (0, 0, 3, 0, 0)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 235, Task #2: Duplicate Zeros (Perl)\n\n";
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

        my $dups = duplicate_zeros( \@ints );

        printf "Output: \@dups = (%s)\n", join ', ', @$dups;
    }
}

#-------------------------------------------------------------------------------
sub duplicate_zeros
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  @dups;

    for my $n (@$ints)
    {
        push @dups, $n;
        push @dups, 0 if $n == 0;
    }

    return [ @dups[ 0 .. $#$ints ] ];
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

        my @ints = split / \s+ /x, $int_str;
        my @exp  = split / \s+ /x, $exp_str;
        my $dups = duplicate_zeros( \@ints );

        is_deeply $dups, \@exp, $test_name;
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
Example 1| 1 0  2  3 0 4 5 0| 1 0 0  2  3 0 0 4
Example 2| 1 2  3           | 1 2 3
Example 3| 0 3  0  4 5      | 0 0 3  0  0
Singleton| 0                | 0
Negatives|-3 0 -2 -1 0      |-3 0 0 -2 -1
