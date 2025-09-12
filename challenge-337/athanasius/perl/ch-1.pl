#!perl

################################################################################
=comment

Perl Weekly Challenge 337
=========================

TASK #1
-------
*Smaller Than Current*

Submitted by: Mohammad Sajid Anwar

You are given an array of numbers, @num1.

Write a script to return an array, @num2, where $num2[i] is the count of all
numbers less than or equal to $num1[i].

Example 1

  Input: @num1 = (6, 5, 4, 8)
  Output: (2, 1, 0, 3)

  index 0: numbers <= 6 are 5, 4    => 2
  index 1: numbers <= 5 are 4       => 1
  index 2: numbers <= 4, none       => 0
  index 3: numbers <= 8 are 6, 5, 4 => 3

Example 2

  Input: @num1 = (7, 7, 7, 7)
  Output: (3, 3, 3, 3)

Example 3

  Input: @num1 = (5, 4, 3, 2, 1)
  Output: (4, 3, 2, 1, 0)

Example 4

  Input: @num1 = (-1, 0, 3, -2, 1)
  Output: (1, 2, 4, 0, 3)

Example 5

  Input: @num1 = (0, 1, 1, 2, 0)
  Output: (1, 3, 3, 4, 1)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. The input numbers are integers.
2. The Task should read:

     Write a script to return an array, @num2, where $num2[i] is the count of
     all *other* numbers less than or equal to $num1[i].

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of integers is entered on the command-line.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<num1> ...]
  perl $0

    [<num1> ...]    A non-empty list of integers
END
#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 337, Task #1: Smaller Than Current (Perl)\n\n";
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
        my @num1 = @ARGV;

        for (@num1)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        }

        printf "Input: \@num1 = (%s)\n", join ', ', @num1;

        my $num2 = smaller_than_current( \@num1 );

        printf "Output: (%s)\n",         join ', ', @$num2;
    }
}

#-------------------------------------------------------------------------------
sub smaller_than_current
#-------------------------------------------------------------------------------
{
    my ($num1) = @_;
    my  %freq;
      ++$freq{$_} for @$num1;

    my  @keys = sort { $a <=> $b } keys %freq;
    my  $sum  = 0;
    my  %cum_freq;

    for my $key (@keys)
    {
        $sum += $freq{$key};
        $cum_freq{$key} = $sum;
    }

    my @num2;

    for my $num (@$num1)
    {
        push @num2, $cum_freq{$num} - 1;
    }

    return \@num2;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $num1_str, $expd_str) = split / \| /x, $line;

        for ($test_name, $num1_str, $expd_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @num1 = split / \s+ /x, $num1_str;
        my $num2 = smaller_than_current( \@num1 );
        my @expd = split / \s+ /x, $expd_str;

        is_deeply $num2, \@expd, $test_name;
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
Example 1| 6 5 4  8  |2 1 0 3
Example 2| 7 7 7  7  |3 3 3 3
Example 3| 5 4 3  2 1|4 3 2 1 0
Example 4|-1 0 3 -2 1|1 2 4 0 3
Example 5| 0 1 1  2 0|1 3 3 4 1
