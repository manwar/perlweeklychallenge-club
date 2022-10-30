#!perl

###############################################################################
=comment

Perl Weekly Challenge 188
=========================

TASK #2
-------
*Total Zero*

Submitted by: Mohammad S Anwar

You are given two positive integers $x and $y.

Write a script to find out the number of operations needed to make both ZERO.
Each operation is made up either of the followings:

  $x = $x - $y if $x >= $y

  or

  $y = $y - $x if $y >= $x (using the original value of $x)

Example 1

  Input: $x = 5, $y = 4
  Output: 5

Example 2

  Input: $x = 4, $y = 6
  Output: 3

Example 3

  Input: $x = 2, $y = 5
  Output: 4

Example 4

  Input: $x = 3, $y = 1
  Output: 3

Example 5

  Input: $x = 7, $y = 4
  Output: 5

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
If no arguments are given on the command line, the test suite is run.

Assumptions
-----------
1. A "positive integer" is an integer > 0.

2. The requirement to make BOTH $x and $y zero does not seem correct. I have
   solved the task by making ONE of $x and $y zero, *which gives the solutions
   in the Examples*. I have also ignored the parenthetical "using the original
   value of $x" in the task description, as I don't know what it means.

   (If one seeks to change BOTH $x = 5 and $y = 4 to zero, it would seem to
   require at least 6 steps, not 5 as given in Example 1:

          -------------------------
            x  y  Step  Operation
          -------------------------
            5  4
                    1    x -= y
            1  4
                    2    y -= x
            1  3
                    3    y -= x
            1  2
                    4    y -= x
            1  1
                    5    x -= y
            0  1
                    6      ??
            0  0
          -------------------------

   and I don't know what the 6th step would be.)

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common;
use Test::More;

const my $TEST_FIELDS => 4;
const my $USAGE       =>
"Usage:
  perl $0 <x> <y>
  perl $0

    <x>    A positive integer
    <y>    A positive integer\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 188, Task #2: Total Zero (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args == 2)
    {
        my ($x, $y) = parse_command_line();

        print  "Input:  \$x = $x, \$y = $y\n";
        printf "Output: %d\n", count_operations( $x, $y );
    }
    else
    {
        error( "Expected 0 or 2 arguments, found $args" );
    }
}

#------------------------------------------------------------------------------
sub count_operations
#------------------------------------------------------------------------------
{
    my ($x, $y) = @_;
    my  $count  = 0;

    while ($x > 0 && $y > 0)
    {
        if ($x >= $y)
        {
            $x -= $y;
        }
        else
        {
            $y -= $x;
        }

        ++$count;
    }

    return $count;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    for my $n (@ARGV)
    {
        $n =~ / ^ $RE{num}{int} $ /x
               or error( qq["$n" is not a valid integer] );

        $n > 0 or error( qq["$n" is not positive] );
    }

    return @ARGV;
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

        my ($test_name, $x, $y, $expected) =
            split / , \s* /x, $line, $TEST_FIELDS;

        is count_operations( $x, $y ), $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1, 5, 4, 5
Example 2, 4, 6, 3
Example 3, 2, 5, 4
Example 4, 3, 1, 3
Example 5, 7, 4, 5
