#!perl

################################################################################
=comment

Perl Weekly Challenge 213
=========================

TASK #1
-------
*Fun Sort*

Submitted by: Mohammad S Anwar

You are given a list of positive integers.

Write a script to sort the all even integers first then all odds in ascending
order.

Example 1

  Input: @list = (1,2,3,4,5,6)
  Output: (2,4,6,1,3,5)

Example 2

  Input: @list = (1,2)
  Output: (2,1)

Example 3

  Input: @list = (1)
  Output: (1)

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

Assumption
----------
A "positive" integer is greater than zero.

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

    [<list> ...]    A non-empty list of positive integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 213, Task #1: Fun Sort (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    else
    {
        my $list   = parse_command_line();

        printf "Input:  \@list = (%s)\n", join ',', @$list;

        my $sorted = fun_sort( $list );

        printf "Output:         (%s)\n",  join ',', @$sorted;
    }
}

#-------------------------------------------------------------------------------
sub fun_sort
#-------------------------------------------------------------------------------
{
    my ($list) = @_;
    my (@evens, @odds);

    for my $element (@$list)
    {
        if ($element % 2 == 0)
        {
            push @evens, $element;
        }
        else
        {
            push @odds,  $element;
        }
    }

    return [ sort( @evens ), sort( @odds ) ];
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    for (@ARGV)
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer]    );
        $_ > 0                 or error( qq["$_" is not a positive integer] );
    }

    return \@ARGV;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $list, $expected) = split / \| /x, $line;

        s/ \s+ $ //x for $test_name, $list;          # Trim whitespace

        my @expected = split / , /x, $expected;
        my @list     = split / , /x, $list;
        my $got      = fun_sort( \@list );

        is_deeply $got, \@expected, $test_name;
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
Example 1|1,2,3,4,5,6|2,4,6,1,3,5
Example 2|1,2        |2,1
Example 3|1          |1
