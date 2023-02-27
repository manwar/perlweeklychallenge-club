#!perl

###############################################################################
=comment

Perl Weekly Challenge 205
=========================

TASK #1
-------
*Third Highest*

Submitted by: Mohammad S Anwar

You are given an array of integers.

Write a script to find out the Third Highest if found otherwise return the
maximum.

Example 1

  Input: @array = (5,3,4)
  Output: 3

  First highest is 5. Second highest is 4. Third highest is 3.

Example 2

  Input: @array = (5,6)
  Output: 6

  First highest is 6. Second highest is 5. Third highest is missing, so maximum
  is returned.

Example 3

  Input: @array = (5,4,4,3)
  Output: 3

  First highest is 5. Second highest is 4. Third highest is 3.

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
    print "\nChallenge 205, Task #1: Third Highest (Perl)\n\n";
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
        my @array = map { $_ + 0 } @ARGV;                           # Normalize

        / ^ $RE{num}{int} $ /x
            or die qq[ERROR: "$_" is not a valid integer\n$USAGE]
                for @array;

        printf "Input:  \@array = (%s)\n", join ',', @array;

        printf "Output: %d\n",  find_third_highest( \@array );
    }
}

#------------------------------------------------------------------------------
sub find_third_highest
#------------------------------------------------------------------------------
{
    my ($array) = @_;
    my  %count;

    ++$count{ $_ } for @$array;

    my @sorted = sort { $a <=> $b } keys %count;

    return scalar( @sorted ) >= 3 ? $sorted[ -3 ] : $sorted[ -1 ];
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

        my @array = map { $_ + 0 } split / , \s* /x, $input;
        my $got   = find_third_highest( \@array );

        is $got, $expected + 0, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1| 5, 3, 4      | 3
Example 2| 5, 6         | 6
Example 3| 5, 4, 4, 3   | 3
Negatives|-1,-2,-3,-4,-2|-3
