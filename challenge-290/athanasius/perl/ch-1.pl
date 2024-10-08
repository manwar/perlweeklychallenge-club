#!perl

################################################################################
=comment

Perl Weekly Challenge 290
=========================

TASK #1
-------
*Double Exist*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find if there exist two indices $i and $j such that:

  1) $i != $j
  2) 0 <= ($i, $j) < scalar @ints
  3) $ints[$i] == 2 * $ints[$j]

Example 1

  Input: @ints = (6, 2, 3, 3)
  Output: true

  For $i = 0, $j = 2
  $ints[$i] = 6 => 2 * 3 =>  2 * $ints[$j]

Example 2

  Input: @ints = (3, 1, 4, 13)
  Output: false

Example 3

  Input: @ints = (2, 1, 4, 2)
  Output: true

  For $i = 2, $j = 3
  $ints[$i] = 4 => 2 * 2 =>  2 * $ints[$j]

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
3. If the constant $VERBOSE is set to a true value, and the output of the Task
   is true, the first (i.e., lowest) values of $i and $j that satisfy the
   required conditions are also displayed.

=cut
#===============================================================================

use v5.32;         # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   => <<END;
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
    print "\nChallenge 290, Task #1: Double Exist (Perl)\n\n";
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

        printf qq[Input:  \@ints = (%s)\n], join ', ', @ints;

        my ($i, $j) = double_exists( \@ints );

        printf "Output: %s\n", defined $i ? 'true' : 'false';

        print  "\n\$i = $i, \$j = $j\n" if $VERBOSE && defined $i;
    }
}

#-------------------------------------------------------------------------------
sub double_exists
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  @solution;

    L_OUTER:
    for my $i (0 .. $#$ints - 1)
    {
        for my $j (1 .. $#$ints)
        {
            next if $i == $j;

            if    ($ints->[ $i ] == 2 * $ints->[ $j ])
            {
                @solution = ($i, $j);
                last L_OUTER;
            }
            elsif ($ints->[ $j ] == 2 * $ints->[ $i ])
            {
                @solution = ($j, $i);
                last L_OUTER;
            }
        }
    }

    return @solution;
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

        my  @ints   = split / \s+ /x, $int_str;
        my  @exp    = split / \s+ /x, $exp_str;
        my ($i, $j) = double_exists( \@ints );

        if (defined $i)
        {
            is $i, $exp[ 0 ],  "$test_name: \$i";
            is $j, $exp[ 1 ],  "$test_name: \$j";
        }
        else
        {
            is  0, scalar @exp, $test_name;
        }
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
Example 1| 6 2  3  3  |0 2
Example 2| 3 1  4 13  |
Example 3| 2 1  4  2  |0 1
Negatives|-3 0 -6  5 5|2 0
