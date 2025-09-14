#!perl

################################################################################
=comment

Perl Weekly Challenge 338
=========================

TASK #2
-------
*Max Distance*

Submitted by: Mohammad Sajid Anwar

You are given two integer arrays, @arr1 and @arr2.

Write a script to find the maximum difference between any pair of values from
both arrays.

Example 1

  Input: @arr1 = (4, 5, 7)
         @arr2 = (9, 1, 3, 4)
  Output: 6

  With element $arr1[0] = 4
  | 4 - 9 | = 5
  | 4 - 1 | = 3
  | 4 - 3 | = 1
  | 4 - 4 | = 0
  max distance = 5

  With element $arr1[1] = 5
  | 5 - 9 | = 4
  | 5 - 1 | = 4
  | 5 - 3 | = 2
  | 5 - 4 | = 1
  max distance = 4

  With element $arr1[2] = 7
  | 7 - 9 | = 2
  | 7 - 1 | = 6
  | 7 - 3 | = 4
  | 7 - 4 | = 4
  max distance = 6

  max (5, 6, 6) = 6

Example 2

  Input: @arr1 = (2, 3, 5, 4)
         @arr2 = (3, 2, 5, 5, 8, 7)
  Output: 6

  With element $arr1[0] = 2
  | 2 - 3 | = 1
  | 2 - 2 | = 0
  | 2 - 5 | = 3
  | 2 - 5 | = 3
  | 2 - 8 | = 6
  | 2 - 7 | = 5
  max distance = 6

  With element $arr1[1] = 3
  | 3 - 3 | = 0
  | 3 - 2 | = 1
  | 3 - 5 | = 2
  | 3 - 5 | = 2
  | 3 - 8 | = 5
  | 3 - 7 | = 4
  max distance = 5

  With element $arr1[2] = 5
  | 5 - 3 | = 2
  | 5 - 2 | = 3
  | 5 - 5 | = 0
  | 5 - 5 | = 0
  | 5 - 8 | = 3
  | 5 - 7 | = 2
  max distance = 3

  With element $arr1[3] = 4
  | 4 - 3 | = 1
  | 4 - 2 | = 2
  | 4 - 5 | = 1
  | 4 - 5 | = 1
  | 4 - 8 | = 4
  | 4 - 7 | = 3
  max distance = 4

  max (5, 6, 3, 4) = 6

Example 3

  Input: @arr1 = (2, 1, 11, 3)
         @arr2 = (2, 5, 10, 2)
  Output: 9

  With element $arr1[0] = 2
  | 2 - 2  | = 0
  | 2 - 5  | = 3
  | 2 - 10 | = 8
  | 2 - 2  | = 0
  max distance = 8

  With element $arr1[1] = 1
  | 1 - 2  | = 1
  | 1 - 5  | = 4
  | 1 - 10 | = 9
  | 1 - 2  | = 1
  max distance = 9

  With element $arr1[2] = 11
  | 11 - 2  | = 9
  | 11 - 5  | = 6
  | 11 - 10 | = 1
  | 11 - 2  | = 9
  max distance = 9

  With element $arr1[3] = 3
  | 3 - 2  | = 1
  | 3 - 5  | = 2
  | 3 - 10 | = 7
  | 3 - 2  | = 1
  max distance = 7

  max (8, 9, 9, 7) = 9

Example 4

  Input: @arr1 = (1, 2, 3)
         @arr2 = (3, 2, 1)
  Output: 2

  With element $arr1[0] = 1
  | 1 - 3 | = 2
  | 1 - 2 | = 1
  | 1 - 1 | = 0
  max distance = 2

  With element $arr1[1] = 2
  | 2 - 3 | = 1
  | 2 - 2 | = 0
  | 2 - 1 | = 1
  max distance = 1

  With element $arr1[2] = 3
  | 3 - 3 | = 0
  | 3 - 2 | = 1
  | 3 - 1 | = 2
  max distance = 2

  max (2, 1, 2) = 2

Example 5

  Input: @arr1 = (1, 0, 2, 3)
         @arr2 = (5, 0)
  Output: 5

  With element $arr1[0] = 1
  | 1 - 5 | = 4
  | 1 - 0 | = 1
  max distance = 4

  With element $arr1[1] = 0
  | 0 - 5 | = 5
  | 0 - 0 | = 0
  max distance = 5

  With element $arr1[2] = 2
  | 2 - 5 | = 3
  | 2 - 0 | = 2
  max distance = 3

  With element $arr1[3] = 3
  | 3 - 5 | = 2
  | 3 - 0 | = 3
  max distance = 3

  max (4, 5, 3, 3) = 5

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
2. Two strings are entered on the command-line. Each string contains a list of
   integers, separated by whitespace.
   
=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <arr1> <arr2>
  perl $0

    <arr1>    First  list of integers
    <arr2>    Second list of integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 338, Task #2: Max Distance (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $argc = scalar @ARGV;

    if    ($argc == 0)
    {
        run_tests();
    }
    elsif ($argc == 2)
    {
        my (@arr1, @arr2);

        for (split / \s+ /x, $ARGV[0])
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
            push @arr1, $_;
        }

        for (split / \s+ /x, $ARGV[1])
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
            push @arr2, $_;
        }

        printf "Input:  \@arr1 = (%s)\n", join ', ', @arr1;
        printf "        \@arr2 = (%s)\n", join ', ', @arr2;

        my $max_diff = find_max_diff( \@arr1, \@arr2 );

        print  "Output: $max_diff\n";
    }
    else
    {
        error( "Expected 0 or 2 command-line arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_max_diff
#-------------------------------------------------------------------------------
{
    my ($arr1, $arr2) = @_;
    my  $max_diff     = 0;

    for my $i (@$arr1)
    {
        for my $j (@$arr2)
        {
            my $diff = abs( $i - $j );

            $max_diff = $diff if $diff > $max_diff;
        }
    }

    return $max_diff;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $arr1_str, $arr2_str, $expected) =
             split / \| /x, $line;

        for ($test_name, $arr1_str, $arr2_str, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @arr1     = split / \s+ /x, $arr1_str;
        my @arr2     = split / \s+ /x, $arr2_str;
        my $max_diff = find_max_diff( \@arr1, \@arr2 );

        is $max_diff, $expected, $test_name;
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
Example 1|4 5  7  |9 1  3 4    |6
Example 2|2 3  5 4|3 2  5 5 8 7|6
Example 3|2 1 11 3|2 5 10 2    |9
Example 4|1 2  3  |3 2  1      |2
Example 5|1 0  2 3|5 0         |5
