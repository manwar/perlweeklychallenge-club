#!perl

###############################################################################
=comment

Perl Weekly Challenge 197
=========================

TASK #1
-------
*Move Zero*

Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to move all zero, if exists, to the end while maintaining the
relative order of non-zero elements.

Example 1

  Input:  @list = (1, 0, 3, 0, 0, 5)
  Output: (1, 3, 5, 0, 0, 0)

Example 2

  Input: @list = (1, 6, 4)
  Output: (1, 6, 4)

Example 3

  Input: @list = (0, 1, 0, 2, 0)
  Output: (1, 2, 0, 0, 0)

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Algorithm
---------
1. Traverse the input list, counting zero values but copying non-zero values to
   the output list.
2. Append the number of zero values encountered in the input list to the end of
   the output list.
   -- The repetition operator 'x' in list context "returns a list consisting of
      the left operand list repeated the number of times specified by the right
      operand" (https://perldoc.perl.org/perlop#Multiplicative-Operators).

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $TEST_FIELDS => 3;
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
    print "\nChallenge 197, Task #1: Move Zero (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    if ($args == 0)
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

        printf "Input:  \@list = (%s)\n", join ', ',            @list;
        printf "Output:         (%s)\n",  join ', ', move_zero( @list );
    }
}

#------------------------------------------------------------------------------
sub move_zero
#------------------------------------------------------------------------------
{
    my @list  = @_;
    my $count = 0;
    my @moved;

    for my $n (@list)
    {
        if ($n == 0)
        {
            ++$count;
        }
        else
        {
            push @moved, $n;
        }
    }

    push @moved, (0) x $count;

    return @moved;
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

        my @list = split / , \s+ /x, $input;
        my $got  = join ', ', move_zero( @list );

        is $got, $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1| 1, 0,  3,  0, 0, 5    | 1,  3,  5,  0, 0, 0
Example 2| 1, 6,  4              | 1,  6,  4
Example 3| 0, 1,  0,  2, 0       | 1,  2,  0,  0, 0
Negatives|-1, 0, -2, -3, 0, 0, -4|-1, -2, -3, -4, 0, 0, 0
