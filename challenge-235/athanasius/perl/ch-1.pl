#!perl

################################################################################
=comment

Perl Weekly Challenge 235
=========================

TASK #1
-------
*Remove One*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out if removing ONLY one integer makes it strictly in-
creasing order.

Example 1

  Input: @ints = (0, 2, 9, 4, 6)
  Output: true

  Removing ONLY 9 in the given array makes it strictly increasing order.

Example 2

  Input: @ints = (5, 1, 3, 2)
  Output: false

Example 3

  Input: @ints = (2, 2, 3)
  Output: true

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumptions
-----------
1. The input list must contain at least 2 integers.
2. If more than one solution is possible, the highest number is selected for the
   VERBOSE output.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. If $VERBOSE is set to a true value (the default), and the output is true, the
   value of the integer to be removed is also displayed.

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
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A list of 2 or more integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 235, Task #1: Remove One (Perl)\n\n";
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
        my $ints = parse_command_line();

        printf "Input:  \@ints = (%s)\n", join ', ', @$ints;

        my $to_remove = remove_one( $ints );

        printf "Output: %s\n", defined $to_remove ? 'True' : 'False';

        print "\nInteger to remove: $to_remove\n"
            if $VERBOSE && defined $to_remove;
    }
}

#-------------------------------------------------------------------------------
sub remove_one
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;

    return $ints->[ -1 ] if scalar @$ints == 2 || is_ordered( $ints );

    for my $i (0 .. $#$ints)
    {
        my $to_remove =  $ints->[ $i ];
        my @sublist   = @$ints[ 0 .. $i - 1, $i + 1 .. $#$ints ];

        return $to_remove if is_ordered( \@sublist );
    }

    return undef;
}

#-------------------------------------------------------------------------------
sub is_ordered
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;

    for my $i (0 .. $#$ints - 1)
    {
        return 0 if $ints->[ $i ] >= $ints->[ $i + 1 ];
    }

    return 1;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    scalar @ARGV > 1       or error( 'Too few arguments in the input list' );

    / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
        for @ARGV;

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

        my  ($test_name, $ints_str, $exp_str) = split / \| /x, $line;

        for ($test_name, $ints_str, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints      = split / \s+ /x, $ints_str;
        my $to_remove = remove_one( \@ints );
        my $expected  = $exp_str eq '' ? undef : $exp_str;

        is $to_remove, $expected, $test_name;
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
Example 1| 0  2 9 4 6| 9
Example 2| 5  1 3 2  |
Example 3| 2  2 3    | 2
Min list |-1 -1      |-1
Ordered  |-1  0 1 2 3| 3
