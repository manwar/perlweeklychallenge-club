#!perl

###############################################################################
=comment

Perl Weekly Challenge 192
=========================

TASK #2
-------
*Equal Distribution*

Submitted by: Mohammad S Anwar

You are given a list of integers greater than or equal to zero, @list.

Write a script to distribute the number so that each members are same. If you
succeed then print the total moves otherwise print -1.

Please follow the rules (as suggested by Neils van Dijke [2022-11-21 13:00])

  1) You can only move a value of '1' per move
  2) You are only allowed to move a value of '1' to a direct neighbor/adjacent
     cell

Example 1:

  Input: @list = (1, 0, 5)
  Output: 4

  Move #1: 1, 1, 4
  (2nd cell gets 1 from the 3rd cell)

  Move #2: 1, 2, 3
  (2nd cell gets 1 from the 3rd cell)

  Move #3: 2, 1, 3
  (1st cell gets 1 from the 2nd cell)

  Move #4: 2, 2, 2
  (2nd cell gets 1 from the 3rd cell)

Example 2:

  Input: @list = (0, 2, 0)
  Output: -1

  It is not possible to make each same.

Example 3:

  Input: @list = (0, 3, 0)
  Output: 2

  Move #1: 1, 2, 0
  (1st cell gets 1 from the 2nd cell)

  Move #2: 1, 1, 1
  (3rd cell gets 1 from the 2nd cell)

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
2. To show (one possible version of) the actual moves, set $VERBOSE to a true
   value. (This has no effect on the running of the test suite.)

Algorithm
---------
sum  := sum of all the list elements
size := number of elements in the list
IF sum is evenly divisible by size THEN
    target := sum / size
    move   := 0
    WHILE list elements are not all equal
        low  := index of first element less    than target
        high := index of first element greater than target
        # Implement one move:
        increment the element beside element[high] on the side closest to
            element[low]
        decrement element[high]
        increment move
    ENDWHILE
    RETURN move
ELSE
    RETURN -1
ENDIF

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $TST_FLDS => 3;
const my $VERBOSE  => 1;
const my $USAGE    =>
"Usage:
  perl $0 [<list> ...]
  perl $0

    [<list> ...]    A non-empty list of non-negative integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 192, Task #2: Equal Distribution (Perl)\n\n";
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

        for my $n (@list)
        {
            $n =~ / ^ $RE{num}{int} $ /x
                    or error( qq["$n is not a valid integer] );

            $n >= 0 or error( qq["$n" is negative] );
        }

        printf "Input:  \@list = (%s)\n", join ', ', @list;
        printf "Output: %d\n", count_moves( 1, @list );
    }
}

#------------------------------------------------------------------------------
sub count_moves
#------------------------------------------------------------------------------
{
    my ($display, @list) = @_;
    my  $size =  scalar @list;
    my  $move = -1;                 # Assume failure
    my  $sum  =  0;
        $sum +=  $_ for @list;

    if ($sum % $size == 0)          # Solution is possible
    {
        $move = 0;

        my $target = $sum / $size;

        until (distribution_is_equal( $target, @list ))
        {
            my $low  = get_idx_low  ( $target, @list );
            my $high = get_idx_high ( $target, @list );

            ++$list[ $high + (($low < $high) ? -1 : 1) ];
            --$list[ $high ];
            ++$move;

            printf "       Move %2d: (%s)\n", $move, join ', ', @list
                if $VERBOSE && $display;
        }
    }

    return $move;
}

#------------------------------------------------------------------------------
sub distribution_is_equal
#------------------------------------------------------------------------------
{
    my ($target, @list) = @_;

    for my $n (@list)
    {
        return 0 unless $n == $target;
    }

    return 1;
}

#------------------------------------------------------------------------------
sub get_idx_low
#------------------------------------------------------------------------------
{
    my ($target, @list) = @_;

    for my $i (0 .. $#list)
    {
        return $i if $list[ $i ] < $target;
    }

    die 'No low index found';
}

#------------------------------------------------------------------------------
sub get_idx_high
#------------------------------------------------------------------------------
{
    my ($target, @list) = @_;

    for my $i (0 .. $#list)
    {
        return $i if $list[ $i ] > $target;
    }

    die 'No high index found';
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

        my ($test_name, $in, $expected) = split / , \s* /x, $line, $TST_FLDS;

        my @list = split / \s+ /x, $in;

        is count_moves( 0, @list ), $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1,     1 0 5,            4
Example 2,     0 2 0,           -1
Example 3,     0 3 0,            2
Bubble left,   4 5 6  7 8 9 10, 28
Bubble right, 10 9 8  7 6 5  4, 28
Middle,        4 9 5 10 8 6  7,  8
Fully centred, 1 1 1  8 1 1  1, 12
