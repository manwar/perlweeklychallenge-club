#!perl

################################################################################
=comment

Perl Weekly Challenge 219
=========================

TASK #1
-------
*Sorted Squares*

Submitted by: Mohammad S Anwar

You are given a list of numbers.

Write a script to square each number in the list and return the sorted list,
increasing order.

Example 1

  Input: @list = (-2, -1, 0, 3, 4)
  Output: (0, 1, 4, 9, 16)

Example 2

  Input: @list = (5, -4, -1, 3, 6)
  Output: (1, 9, 16, 25, 36)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The input numbers are integers.

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

const my $USAGE =>
"Usage:
  perl $0 [<list> ...]
  perl $0

    [<list> ...]    A list of 1 or more integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 219, Task #1: Sorted Squares (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $args = scalar @ARGV;

    if ($args == 0)
    {
        run_tests();
    }
    else
    {
        / ^ $RE{num}{int} $ /x or error( qq[Invalid integer "$_"] ) for @ARGV;

        printf "Input:  \@list = (%s)\n", join ', ', @ARGV;

        my $output = square_and_sort( \@ARGV );

        printf "Output: (%s)\n", join ', ', @$output;
    }
}

#-------------------------------------------------------------------------------
sub square_and_sort
#-------------------------------------------------------------------------------
{
    my ($list) = @_;
    my  @solution;

    push @solution, $_ * $_ for @$list;

    @solution = sort { $a <=> $b } @solution;

    return \@solution;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $list_str, $expd_str) = split / \| /x, $line;

        for ($test_name, $list_str, $expd_str)                 # Trim whitespace
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @expected   = split / \, \s* /x,  $expd_str;
        my @input_list = split / \, \s* /x,  $list_str;
        my $solution   = square_and_sort( \@input_list );

        is_deeply $solution, \@expected, $test_name;
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
Example 1|-2, -1,  0, 3, 4|0, 1,  4,  9, 16
Example 2| 5, -4, -1, 3, 6|1, 9, 16, 25, 36
