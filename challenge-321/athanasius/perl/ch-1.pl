#!perl

################################################################################
=comment

Perl Weekly Challenge 321
=========================

TASK #1
-------
*Distinct Average*

Submitted by: Mohammad Sajid Anwar

You are given an array of numbers with even length.

Write a script to return the count of distinct average. The average is calculate
by removing the minimum and the maximum, then average of the two.

Example 1

  Input: @nums = (1, 2, 4, 3, 5, 6)
  Output: 1

  Step 1: Min = 1, Max = 6, Avg = 3.5
  Step 2: Min = 2, Max = 5, Avg = 3.5
  Step 3: Min = 3, Max = 4, Avg = 3.5

  The count of distinct average is 1.

Example 2

  Input: @nums = (0, 2, 4, 8, 3, 5)
  Output: 2

  Step 1: Min = 0, Max = 8, Avg = 4
  Step 2: Min = 2, Max = 5, Avg = 3.5
  Step 3: Min = 3, Max = 4, Avg = 3.5

  The count of distinct average is 2.

Example 3

  Input: @nums = (7, 3, 1, 0, 5, 9)
  Output: 2

  Step 1: Min = 0, Max = 9, Avg = 4.5
  Step 2: Min = 1, Max = 7, Avg = 4
  Step 3: Min = 3, Max = 5, Avg = 4

  The count of distinct average is 2.

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
2. A non-empty, even-sized list of numbers is entered on the command-line.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

use constant DEBUG => 0;
use if DEBUG, 'Data::Dump', qw( pp );

const my $USAGE => <<END;
Usage:
  perl $0 [<nums> ...]
  perl $0

    [<nums> ...]    A non-empty, even-sized list of numbers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 321, Task #1: Distinct Average (Perl)\n\n";
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
        printf "Raw input: %s\n", pp( \@ARGV ) if DEBUG;

        / ^ $RE{num}{real} $ /x or error( qq["$_" is not a valid real number] )
            for @ARGV;

        my @nums = map { $_ + 0 } @ARGV;                             # Normalize

        scalar @nums % 2 == 0  or error( 'The input list is uneven' );

        printf "Input:  \@nums = (%s)\n", join ', ', @nums;

        my $count = count_distinct_avgs( \@nums );

        print  "Output: $count\n";
    }
}

#-------------------------------------------------------------------------------
sub count_distinct_avgs
#-------------------------------------------------------------------------------
{
    my ($nums)  = @_;
    my  @sorted = sort { $a <=> $b } @$nums;
    my  %distinct_avgs;

    while (scalar @sorted >= 2)
    {
        my $min = shift @sorted;
        my $max = pop   @sorted;
        my $avg = ($min + $max) / 2;

        ++$distinct_avgs{ $avg };
    }

    printf "Distinct averages: %s\n", pp( \%distinct_avgs ) if DEBUG;

    return scalar keys %distinct_avgs;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $nums_str, $expected) = split / \| /x, $line;

        for ($test_name, $nums_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @nums  = split / \s+ /x, $nums_str;
        my $count = count_distinct_avgs( \@nums );

        is $count, $expected, $test_name;
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
Example 1|1 2 4 3 5 6|1
Example 2|0 2 4 8 3 5|2
Example 3|7 3 1 0 5 9|2
