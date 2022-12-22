#!perl

###############################################################################
=comment

Perl Weekly Challenge 196
=========================

TASK #2
-------
*Range List*

Submitted by: Mohammad S Anwar

You are given a sorted unique integer array, @array.

Write a script to find all possible Number Range i.e [x, y] represent range all integers from x and y (both inclusive).

    Each subsequence of two or more contiguous integers

Example 1

  Input: @array = (1,3,4,5,7)
  Output: [3,5]

Example 2

  Input: @array = (1,2,3,6,7,9)
  Output: [1,3], [6,7]

Example 3

  Input: @array = (0,1,2,4,5,6,8,9)
  Output: [0,2], [4,6], [8,9]

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

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Data::Compare;
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
    print "\nChallenge 196, Task #2: Range List (Perl)\n\n";
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
        my $array  = parse_command_line();

        printf "Input:  \@array = (%s)\n", join ',', @$array;

        my $ranges = find_ranges( $array );

        printf "Output: %s\n",
                join ', ', map { '[' . join( ',', @$_ ) . ']' } @$ranges;
    }
}

#------------------------------------------------------------------------------
sub find_ranges
#------------------------------------------------------------------------------
{
    my ($array) = @_;
    my (@range, @ranges);

    for my $n (@$array)
    {
        if (scalar @range == 0      ||       # Start the first range
            $n == $range[ -1 ] + 1)          # Extend an existing range
        {
            push @range, $n;
        }
        else                                 # Start a new range
        {
            # First, handle (either keep or discard) the previous range

            push @ranges, [ @range ] if scalar @range > 1;

            @range = $n;
        }
    }

    push @ranges, \@range if scalar @range > 1;        # Handle the final range

    @$_ = @$_[ 0, -1 ] for @ranges;    # Remove all middle elements from ranges

    return \@ranges;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my (@array, %integers);

    for my $n (@ARGV)
    {
        $n =~ / ^ $RE{num}{int} $ /x
            or error( qq["$n" is not a valid integer] );

        push @array, $n;

        ++$integers{ $n } == 1
            or error( 'Elements of the input array are not unique: ' .
                       qq["$n" appears twice] );
    }

    my @sorted = sort { $a <=> $b } @array;

    Compare( \@array, \@sorted )
        or error( 'The input array is not sorted' );

    return \@array;
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
            split / \| /x, $line, $TEST_FIELDS;

        $input    =~ s/ ^ \s* (.+) \s* $ /$1/x;               # Trim whitespace
        $expected =~ s/ ^ \s* (.+) \s* $ /$1/x;

        my @array  = split / \s+ /x, $input;
        my $ranges = find_ranges( \@array );
        my $got    = join ', ', map { '[' . join( ',', @$_ ) . ']' } @$ranges;

        is $got, $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1| 1  3  4 5 7      |[3,5]
Example 2| 1  2  3 6 7 9    |[1,3], [6,7]
Example 3| 0  1  2 4 5 6 8 9|[0,2], [4,6], [8,9]
Negatives|-3 -2 -1 1 2 5 6  |[-3,-1], [1,2], [5,6]
