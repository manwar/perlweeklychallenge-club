#!perl

################################################################################
=comment

Perl Weekly Challenge 283
=========================

TASK #1
-------
*Unique Number*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints, where every elements appears more
than once except one element.

Write a script to find the one element that appears exactly one time.

Example 1

  Input: @ints = (3, 3, 1)
  Output: 1

Example 2

  Input: @ints = (3, 2, 4, 2, 4)
  Output: 3

Example 3

  Input: @ints = (1)
  Output: 1

Example 4

  Input: @ints = (4, 3, 1, 1, 1, 4)
  Output: 3

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
2. A list of integers is entered on the command-line.

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

    [<ints> ...]    List of integers in which exactly 1 int appears exactly once
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 283, Task #1: Unique Number (Perl)\n\n";
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

            $_ += 0;                          # Normalize (e.g., change -0 to 0)
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $unique_num = find_unique_num( \@ints );

        if (defined $unique_num)
        {
            print "Output: $unique_num\n";
        }
        else
        {
            print "\n";
            error( 'The input list is invalid' );
        }
    }
}

#-------------------------------------------------------------------------------
sub find_unique_num
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  %count;

    ++$count{ $_ } for @$ints;

    my @singletons = grep { $count{ $_ } == 1 } keys %count;

    return scalar @singletons == 1 ? $singletons[ 0 ] : undef;
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

        my @ints       = split / \s+ /x, $ints_str;
        my $unique_num = find_unique_num( \@ints );

        defined $unique_num or die( 'Invalid test data' );

        is $unique_num, $expected, $test_name;
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
Example 1|3 3 1      |1
Example 2|3 2 4 2 4  |3
Example 3|1          |1
Example 4|4 3 1 1 1 4|3
