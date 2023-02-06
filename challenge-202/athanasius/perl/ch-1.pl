#!perl

###############################################################################
=comment

Perl Weekly Challenge 202
=========================

TASK #1
-------
*Consecutive Odds*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to print 1 if there are THREE consecutive odds in the given
array otherwise print 0.

Example 1

  Input: @array = (1,5,3,6)
  Output: 1

Example 2

  Input: @array = (2,6,3,5)
  Output: 0

Example 3

  Input: @array = (1,2,3,4)
  Output: 0

Example 4

  Input: @array = (2,3,5,7)
  Output: 1

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

Assumption
----------
Where the Task description says "if there are THREE consecutive odds in the
given array", it means "if there are AT LEAST THREE consecutive odds in the
given array".

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<array> ...]
  perl $0

    [<array> ...]    A list of 1 or more integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 202, Task #1: Consecutive Odds (Perl)\n\n";
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
        my @array = @ARGV;

        / ^ $RE{num}{int} $ /x
            or die qq[ERROR: "$_" is not a valid integer\n$USAGE]
                for @array;

        printf "Input:  \@array = (%s)\n", join ',', @array;

        printf "Output: %d\n", three_consecutive_odds( \@array );
    }
}

#------------------------------------------------------------------------------
sub three_consecutive_odds
#------------------------------------------------------------------------------
{
    my ($array) = @_;
    my  $found  = 0;
    my  $count  = 0;                # Count of consecutive odd numbers

    for my $n (@$array)
    {
        if ($n % 2 == 0)            # Even
        {
            $count = 0;             # Reset the count
        }
        elsif (++$count == 3)       # Odd and 3 consecutive odds found
        {
            $found = 1;
            last;
        }
    }

    return $found;
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $input, $expected) = split / \| /x, $line;

        my @array = split / , \s* /x, $input;
        my $got   = three_consecutive_odds( \@array );

        is $got, $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1|1,5,3,6|1
Example 2|2,6,3,5|0
Example 3|1,2,3,4|0
Example 4|2,3,5,7|1
