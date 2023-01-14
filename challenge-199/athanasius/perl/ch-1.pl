#!perl

###############################################################################
=comment

Perl Weekly Challenge 199
=========================

TASK #1
-------
*Good Pairs*

Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to find the total count of Good Pairs.


    A pair (i, j) is called good if list[i] == list[j] and i < j.


Example 1

  Input: @list = (1,2,3,1,1,3)
  Output: 4

  There are 4 good pairs found as below:
  (0,3)
  (0,4)
  (3,4)
  (2,5)

Example 2

  Input: @list = (1,2,3)
  Output: 0

Example 3

  Input: @list = (1,1,1,1)
  Output: 6

  Good pairs are below:
  (0,1)
  (0,2)
  (0,3)
  (1,2)
  (1,3)
  (2,3)

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
2. Otherwise, if $VERBOSE is set to a true value, an explanation like that in
   Examples 1 and 3 is appended to the solution.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $TEST_FIELDS => 3;
const my $VERBOSE     => 1;
const my $USAGE       =>
"Usage:
  perl $0 [<list> ...]
  perl $0

    [<list> ...]    A list of 1 or more integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 199, Task #1: Good Pairs (Perl)\n\n";
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
        my @list = @ARGV;

        for (@list)
        {
            / ^ $RE{num}{int} $ /x
                or die qq[ERROR: "$_" is not a valid integer\n$USAGE];
        }

        printf "Input:  \@list = (%s)\n", join ',', @list;

        my $pairs = find_good_pairs( \@list );

        printf "Output: %d\n", scalar @$pairs;

        give_details( $pairs ) if $VERBOSE;
    }
}

#------------------------------------------------------------------------------
sub find_good_pairs
#------------------------------------------------------------------------------
{
    my ($list) = @_;
    my  @pairs;

    for my $i (0 .. $#$list - 1)
    {
        for my $j ($i + 1 .. $#$list)
        {
            if ($list->[ $i ] == $list->[ $j ])
            {
                push @pairs, [ $i, $j ];
            }
        }
    }

    return \@pairs;
}

#------------------------------------------------------------------------------
sub give_details
#------------------------------------------------------------------------------
{
    my ($pairs) = @_;
    my  $count  = scalar @$pairs;

    if    ($count == 0)
    {
        print  "\nThere are no good pairs in the list\n";
    }
    elsif ($count == 1)
    {
        printf "\nThere is 1 good pair in the list:\n(%s)\n",
                join( ',', @{ $pairs->[ 0 ] });
    }
    else
    {
        print  "\nThere are $count good pairs in the list:\n";

        print  '(', join( ',', @$_ ), ")\n" for @$pairs;
    }
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $input, $expected) = split /\|/, $line, $TEST_FIELDS;

        $input    =~ s/ ^ \s* (.+?) \s* $ /$1/x;              # Trim whitespace
        $expected =~ s/ ^ \s* (.+?) \s* $ /$1/x;
        $expected =~ s/   \s+             / /gx;

        my @list  = split / , \s* /x, $input;
        my $pairs = find_good_pairs( \@list );
        my $got   = scalar @$pairs;

        is $got, $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1| 1, 2, 3, 1, 1, 3|4
Example 2| 1, 2, 3         |0
Example 3| 1, 1, 1, 1      |6
Negatives|-1,-2,-3,-1,-1,-3|4
