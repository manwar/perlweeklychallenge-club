#!perl

################################################################################
=comment

Perl Weekly Challenge 228
=========================

TASK #1
-------
*Unique Sum*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out the sum of unique elements in the given array.

Example 1

  Input: @int = (2, 1, 3, 2)
  Output: 4

  In the given array we have 2 unique elements (1, 3).

Example 2

  Input: @int = (1, 1, 1, 1)
  Output: 0

  In the given array no unique element found.

Example 3

  Input: @int = (2, 1, 3, 4)
  Output: 10

  In the given array every element is unique.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value, the solution is followed by a list of the
   unique elements in the array.

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
  perl $0 <year>
  perl $0

    <year>    A non-empty list of integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 228, Task #1: Unique Sum (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my  $args = scalar @ARGV;

    if ($args == 0)
    {
        run_tests();
    }
    else
    {
        my @int = @ARGV;

        for (@int)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
        }

        printf "Input:  \@int = (%s)\n", join ', ', @int;

        my ($sum, $uniq) = find_sum( \@int );

        print  "Output: $sum\n";

        printf "\nUnique elements: (%s)\n", join ', ', @$uniq if $VERBOSE;
    }
}

#-------------------------------------------------------------------------------
sub find_sum
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;

    my  %freq;
      ++$freq{ $_ } for @$ints;

    my  $sum = 0;
    my  @uniq;

    for my $n (@$ints)
    {
        if ($freq{ $n } == 1)
        {
            $sum += $n;
            push @uniq, $n;
        }
    }

    @uniq = sort { $a <=> $b } @uniq;

    return ($sum, \@uniq);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test, $int_str, $exp_sum, $exp_uniq_str) = split / \| /x, $line;

        for ($test, $int_str, $exp_sum, $exp_uniq_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my  @int         = split / \s+ /x, $int_str;
        my  @exp_uniq    = split / \s+ /x, $exp_uniq_str;
        my ($sum, $uniq) = find_sum( \@int );

        is        $sum,   $exp_sum,  "$test: sum";
        is_deeply $uniq, \@exp_uniq, "$test: unique";
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
Example 1|2 1 3 2| 4|1 3
Example 2|1 1 1 1| 0|
Example 3|2 1 3 4|10|1 2 3 4
