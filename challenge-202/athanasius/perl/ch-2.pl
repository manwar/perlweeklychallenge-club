#!perl

###############################################################################
=comment

Perl Weekly Challenge 202
=========================

TASK #2
-------
*Widest Valley*

Submitted by: E. Choroba

Given a profile as a list of altitudes, return the leftmost *widest valley*. A
valley is defined as a subarray of the profile consisting of two parts: the
first part is non-increasing and the second part is non-decreasing. Either part
can be empty.

Example 1

  Input: 1, 5, 5, 2, 8
  Output: 5, 5, 2, 8

Example 2

  Input: 2, 6, 8, 5
  Output: 2, 6, 8

Example 3

  Input: 9, 8, 13, 13, 2, 2, 15, 17
  Output: 13, 13, 2, 2, 15, 17

Example 4

  Input: 2, 1, 2, 1, 3
  Output: 2, 1, 2

Example 5

  Input: 1, 3, 3, 2, 1, 2, 3, 3, 2
  Output: 3, 3, 2, 1, 2, 3, 3

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
Altitudes are relative to sea level (and may therefore be negative), but are
restricted to integer values as per the Examples.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<altitudes> ...]
  perl $0

    [<altitudes> ...]    A non-empty list of integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 202, Task #2: Widest Valley (Perl)\n\n";
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
        my @altitudes = @ARGV;

        for (@altitudes)
        {
            / ^ $RE{num}{int} $ /x
                or die qq[ERROR: "$_" is not a valid integer\n$USAGE];
        }

        printf "Input:  %s\n", join ', ', @altitudes;

        my $valley = find_widest_valley( \@altitudes );

        printf "Output: %s\n", join ', ', @$valley;
    }
}

#------------------------------------------------------------------------------
# Given a profile as a list of altitudes, return the leftmost *widest valley*.
# A valley is defined as a subarray of the profile consisting of two parts: the
# first part is non-increasing and the second part is non-decreasing. Either
# part can be empty.
#
# Example 1   Input:  1, 5, 5, 2, 8
#             Output:    5, 5, 2, 8
#
# Example 2   Input:  2, 6, 8, 5
#             Output: 2, 6, 8
#
# Example 3   Input:  9, 8, 13, 13, 2, 2, 15, 17
#             Output:       13, 13, 2, 2, 15, 17
#
# Example 4   Input:  2, 1, 2, 1, 3
#             Output: 2, 1, 2
#
# Example 5   Input:  1, 3, 3, 2, 1, 2, 3, 3, 2
#             Output:    3, 3, 2, 1, 2, 3, 3
#------------------------------------------------------------------------------
sub find_widest_valley
#------------------------------------------------------------------------------
{
    my ($altitudes) = @_;
    my  $in_left    = 1;
    my  @valley     = $altitudes->[ 0 ];
    my  @widest;

    for (my $idx = 1; $idx <= $#$altitudes; ++$idx)
    {
        my $last = $valley[ -1 ];
        my $next = $altitudes->[ $idx ];

        if    ($in_left)            # In the left part of the valley
        {
            push @valley, $next;

            $in_left = 0 if $next > $last;    # Change direction: left to right
        }
        elsif ($next >= $last)      # In the right part of the valley
        {
            push @valley, $next;
        }
        else                                  # Change direction: right to left
        {
            # Backtrack to left-most non-ascending altitude

            --$idx while $altitudes->[ $idx - 1 ] >= $altitudes->[ $idx ];

            @widest  = @valley if scalar @valley > scalar @widest;
            @valley  = $altitudes->[ $idx ];
            $in_left = 1;
        }
    }

    @widest = @valley if scalar @valley > scalar @widest;

    return \@widest;
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test, $in, $out) = split / \| /x, $line;

        $in =~ s/ (.+?) \s* $ /$1/x;                 # Trim trailing whitespace

        my @altitudes = split /,/, $in;
        my @expected  = split /,/, $out;

        is_deeply find_widest_valley( \@altitudes ), \@expected, $test;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1|1,5,5,2,8                   |5,5,2,8
Example 2|2,6,8,5                     |2,6,8
Example 3|9,8,13,13,2,2,15,17         |13,13,2,2,15,17
Example 4|2,1,2,1,3                   |2,1,2
Example 5|1,3,3,2,1,2,3,3,2           |3,3,2,1,2,3,3
First    |5,4,3,2,4,5,4,3,1,4,5       |5,4,3,2,4,5
Second   |10,7,3,5,9,9,8,6,4,4,3,5,7,1|9,9,8,6,4,4,3,5,7
Negatives|3,2,0,-1,-2,4,5,3,2         |3,2,0,-1,-2,4,5
No left  |1,2,3,4,5,3,2               |1,2,3,4,5
No right |11,10,9,10,11,8,5,3,1,0,0   |11,8,5,3,1,0,0
