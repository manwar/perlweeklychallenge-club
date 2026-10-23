#!perl

################################################################################
=comment

Perl Weekly Challenge 396
=========================

TASK #1
-------
*Finishing Order*

Submitted by: Mohammad Sajid Anwar

You are given two array of integers, @order and @friends.

The @order (size n) contains every integer from 1 to n exactly once. The
@friends contains ID in sorted in strictly increasing order.

Write a script to return the array containing IDs in finishing order.

Example 1

  Input: @order = (3, 1, 4, 2, 5)
         @friends = (1, 2, 4)
  Output: (1, 4, 2)

  ID 1 finished 2nd.
  ID 4 finished 3rd.
  ID 2 finished 4th.

Example 2

  Input: @order = (5, 4, 3, 2, 1)
         @friends = (1, 3, 5)
  Output: (5, 3, 1)

  ID 5 finished 1st.
  ID 3 finished 3rd.
  ID 1 finished 5th.

Example 3

  Input: @order = (2, 4, 1, 3)
         @friends = (1, 2, 3, 4)
  Output: (2, 4, 1, 3)

  ID 2 finished 1st.
  ID 4 finished 2nd.
  ID 1 finished 3rd.
  ID 3 finished 4th.

Example 4

  Input: @order = (4, 1, 3, 2)
         @friends = (3)
  Output: (3)

Example 5

  Input: @order = (1, 3, 2, 6, 5, 4)
         @friends = (1, 2, 3)
  Output: (1, 3, 2)

  ID 1 finished 1st.
  ID 3 finished 2nd.
  ID 2 finished 3rd.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2026 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. Two strings are entered on the command-line. Each string is a list of
   positive integers separated by whitespace and/or commas.

=cut
#===============================================================================

use v5.38.2;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 <order> <friends>
  perl $0

    <order>      A list of n integers, 1 to n
    <friends>    A list of integers in the range 1 to n
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 396, Task #1: Finishing Order (Perl)\n\n";
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
        my $order   = parse_order  ( $ARGV[0] );
        my $friends = parse_friends( $ARGV[1], scalar @$order );

        printf "Input:  \@order   = (%s)\n", join ', ', @$order;
        printf "        \@friends = (%s)\n", join ', ', @$friends;

        my $finishing = find_finishing_order( $order, $friends );

        printf "Output: (%s)\n", join ', ', @$finishing;
    }
    else
    {
        error( "Expected 0 or 2 arguments, found $argc" );
    }
}

#-------------------------------------------------------------------------------
sub find_finishing_order
#-------------------------------------------------------------------------------
{
    my ($order, $friends) = @_;
    my  %dict;
        $dict{ $order->[$_] } = $_ for 0 .. $#$order;

    return [ sort { $dict{ $a } <=> $dict{ $b } } @$friends ];
}

#-------------------------------------------------------------------------------
sub parse_order
#-------------------------------------------------------------------------------
{
    my ($order_str) = @_;
    my  @order = split / \s+ | \, \s* /x, $order_str;

    for my $n (@order)
    {
        $n =~ / ^ $RE{num}{int} $ /x
                                 or error( qq["$n" is not a valid integer] );
        1 <= $n <= scalar @order or error( "$n is out of range");
    }

    my @in_order = sort { $a <=> $b } @order;

    # @order (size n) contains every integer from 1 to n exactly once

    for my $i (0 .. $#in_order)
    {
        $in_order[$i] == $i + 1  or error( "\@order is invalid" );
    }

    return \@order;
}

#-------------------------------------------------------------------------------
sub parse_friends
#-------------------------------------------------------------------------------
{
    my ($friends_str, $n) = @_;
    my  @friends = split / \s+ | \, \s* /x, $friends_str;

    for my $f (@friends)
    {
        $f =~ / ^ $RE{num}{int} $ /x
                      or error( qq["$f" is not a valid integer] );
        1 <= $f <= $n or error( "$f is out of range");
    }

    # @friends contains ID in @sorted in strictly increasing order

    for my $i (1 .. $#friends)
    {
        $friends[$i] > $friends[$i - 1] or error( "\@friends is invalid" );
    }

    return \@friends;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $order_str, $friends_str, $exp_str) =
             split / \| /x, $line;

        for ($test_name, $order_str, $friends_str, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my $order     = parse_order( $order_str );
        my $friends   = parse_friends( $friends_str, scalar @$order );
        my $finishing = find_finishing_order( $order, $friends );
        my @expected  = split / \s+ /x, $exp_str;

        is_deeply $finishing, \@expected, $test_name;
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
Example 1|3 1 4 2 5  |1 2 4  |1 4 2
Example 2|5 4 3 2 1  |1 3 5  |5 3 1
Example 3|2 4 1 3    |1 2 3 4|2 4 1 3
Example 4|4 1 3 2    |3      |3
Example 5|1 3 2 6 5 4|1 2 3  |1 3 2
