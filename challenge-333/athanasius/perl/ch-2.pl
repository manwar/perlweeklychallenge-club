#!perl

################################################################################
=comment

Perl Weekly Challenge 333
=========================

TASK #2
-------
*Duplicate Zeros*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to duplicate each occurrence of zero, shifting the remaining
elements to the right. The elements beyond the length of the original array are
not written.

Example 1

  Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
  Output: (1, 0, 0, 2, 3, 0, 0, 4)

  Each zero is duplicated.
  Elements beyond the original length (like 5 and last 0) are discarded.

Example 2

  Input: @ints = (1, 2, 3)
  Output: (1, 2, 3)

  No zeros exist, so the array remains unchanged.

Example 3

  Input: @ints = (1, 2, 3, 0)
  Output: (1, 2, 3, 0)

Example 4

  Input: @ints = (0, 0, 1, 2)
  Output: (0, 0, 0, 0)

Example 5

  Input: @ints = (1, 2, 0, 3, 4)
  Output: (1, 2, 0, 0, 3)

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
2. A non-empty list of integers is entered on the command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
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
    print "\nChallenge 333, Task #2: Duplicate Zeros (Perl)\n\n";
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

        my $dups = duplicate_zeros( \@ints );

        printf "Output:        (%s)\n",  join ', ', @$dups;
    }
}

#-------------------------------------------------------------------------------
sub duplicate_zeros
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  @dups;

    for my $int (@$ints)
    {
        push @dups, $int;
        push @dups, 0 if $int == 0;
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
        my @exps = split / \s+ /x, $exp_str;
        my $dups = duplicate_zeros( \@ints );

        is_deeply $dups, \@exps, $test_name;
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
Example 1|1 0 2 3 0 4 5 0|1 0 0 2 3 0 0 4
Example 2|1 2 3          |1 2 3
Example 3|1 2 3 0        |1 2 3 0
Example 4|0 0 1 2        |0 0 0 0
Example 5|1 2 0 3 4      |1 2 0 0 3
