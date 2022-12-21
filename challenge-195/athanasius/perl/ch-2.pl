#!perl

###############################################################################
=comment

Perl Weekly Challenge 195
=========================

TASK #2
-------
*Most Frequent Even*

Submitted by: Mohammad S Anwar

You are given a list of numbers, @list.

Write a script to find most frequent even numbers in the list. In case you get
more than one even numbers then return the smallest even integer. For all other
case, return -1.

Example 1

  Input: @list = (1,1,2,6,2)
  Output: 2 as there are only 2 even numbers 2 and 6 and of those 2 appears the
          most.

Example 2

  Input: @list = (1,3,5,7)
  Output: -1 since no even numbers found in the list

Example 3

  Input: @list = (6,4,4,6,1)
  Output: 4 since there are only two even numbers 4 and 6. They both appears
          the equal number of times, so pick the smallest.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Note
----
"In mathematics, parity is the property of an integer of whether it is even or
 odd. An integer is even if it is a multiple of two, and odd if it is not. For
 example, −4, 0, 82 are even..." -- "Parity (mathematics)", Wikipedia.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $TEST_FIELDS => 3;
const my $USAGE       =>
qq[Usage:
  perl $0 [<list> ...]
  perl $0

    [<list> ...]    A non-empty list of integers\n];

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 195, Task #2: Most Frequent Even (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my $list = parse_command_line();

        printf "Input:  \@list = (%s)\n", join ', ', @$list;

        printf "Output: %d\n", max_even_freq( $list );
    }
}

#------------------------------------------------------------------------------
sub max_even_freq
#------------------------------------------------------------------------------
{
    my ($list) = @_;
    my  %freq;

    for my $n (@$list)
    {
        ++$freq{ $n } if $n % 2 == 0;
    }

    my $solution = -1;
    my $max_freq =  0;

    while (my ($key, $value) = each %freq)
    {
        if    ($value >  $max_freq)
        {
            $solution = $key;
            $max_freq = $value;
        }
        elsif ($value == $max_freq && $key < $solution)
        {
            $solution = $key;
        }
    }

    return $solution;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my @list;

    for my $n (@ARGV)
    {
        $n =~ / ^ $RE{num}{int} $ /x
            or error( qq["$n" is not a valid integer] );

        push @list, $n;
    }

    return \@list;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $input, $expected) =
            split / , \s* /x, $line, $TEST_FIELDS;

        my  @list = split / \s+ /x, $input;

        is max_even_freq( \@list ), $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1,  1  1  2  6  2,        2
Example 2,  1  3  5  7,          -1
Example 3,  6  4  4  6  1,        4
Negatives, -2 -3 -2 -5 -4 -4 -2, -2
