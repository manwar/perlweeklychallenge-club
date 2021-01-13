#!perl

###############################################################################
=comment

Perl Weekly Challenge 079
=========================

Task #2
-------
*Trapped Rain Water*

Submitted by: Mohammad S Anwar

You are given an array of positive numbers @N.

Write a script to represent it as Histogram Chart and find out how much water
it can trap.

Example 1:

Input: @N = (2, 1, 4, 1, 2, 5)
The histogram representation of the given array is as below.

         5           #
         4     #     #
         3     #     #
         2 #   #   # #
         1 # # # # # #
         _ _ _ _ _ _ _
           2 1 4 1 2 5

Looking at the above histogram, we can see, it can trap 1 unit of rain water
between 1st and 3rd column. Similary it can trap 5 units of rain water between
3rd and last column.

Therefore your script should print 6.

Example 2:

Input: @N = (3, 1, 3, 1, 1, 5)
The histogram representation of the given array is as below.

         5           #
         4           #
         3 #   #     #
         2 #   #     #
         1 # # # # # #
         _ _ _ _ _ _ _
           3 1 3 1 1 5

Looking at the above histogram, we can see, it can trap 2 units of rain water
between 1st and 3rd column. Also it can trap 4 units of rain water between 3rd
and last column.

Therefore your script should print 6.

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Notes
-----
To imagine the histogram trapping water, we have to also imagine (transparent!)
walls in front and behind. It seems perfectly in keeping to also imagine a
floor beneath row 1. Therefore, rows with 0 height can still trap water, pro-
vided there are walls to the left and right.

The algorithm used is naive but simple (and therefore straightforward to imple-
ment): for every empty square in the histogram, determine whether there are
walls to its left and right; if so, it can trap rain water.

Note that no water can be trapped in the left-most or right-most columns.

=cut
#==============================================================================

                                    # Exports:
use strict;
use warnings;
use Const::Fast;                    # const()
use List::Util     qw( max );
use Regexp::Common qw( number );    # %RE{num}

#------------------------------------------------------------------------------
# Constants
#------------------------------------------------------------------------------

const my $MAX_COLUMNS => 38;    # (For my particular command-line screen setup)
const my $MAX_HEIGHT  => 31;    #  N.B.: The logic in print_histogram() below
                                #        assumes that $MAX_HEIGHT < 100
const my $USAGE       =>
"Usage:
  perl $0 [<N> ...]

    [<N> ...]    A non-empty array of positive integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 079, Task #2: Trapped Rain Water (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @N = parse_command_line();

    printf "Input: \@N = (%s)\n\n", join ', ', @N;
    print  "Histogram representation:\n\n";

    print_histogram(@N);

    my $water = 0;

    for my $col (1 .. $#N - 1)
    {
        for my $row ($N[$col] + 1 .. max @N)
        {
            ++$water if is_wall_left (\@N, $col, $row) &&
                        is_wall_right(\@N, $col, $row);
        }
    }

    print "\nThis histogram can trap $water units of rain water\n";
}

#------------------------------------------------------------------------------
sub is_wall_left
#------------------------------------------------------------------------------
{
    my ($N, $column, $row) = @_;

    for my $col (reverse(0 .. $column - 1))
    {
        return 1 if $N->[$col] >= $row;
    }

    return 0;
}

#------------------------------------------------------------------------------
sub is_wall_right
#------------------------------------------------------------------------------
{
    my ($N, $column, $row) = @_;

    for my $col ($column + 1 .. $#$N)
    {
        return 1 if $N->[$col] >= $row;
    }

    return 0;
}

#------------------------------------------------------------------------------
# From Perl Weekly Challenge #075, Task 2: Largest Rectangle Histogram
#
sub print_histogram
#------------------------------------------------------------------------------
{
    my @N          = @_;
    my $columns    = scalar @N;
    my $max_height = max @N;

    if ($columns    <= $MAX_COLUMNS &&
        $max_height <= $MAX_HEIGHT)
    {
        for my $row (reverse 1 .. $max_height)
        {
            printf " %2d", $row;
            print  $_ >= $row ? ' #' : '  ' for @N;
            print  "\n";
        }

        printf "  _%s\n", ' _' x $columns;

        if ($max_height < 10)
        {
            printf "    %s\n", join ' ', @N;
        }
        else
        {
            printf "    %s\n", join ' ', map { int($_ / 10) || ' ' } @N;
            printf "    %s\n", join ' ', map {     $_ % 10         } @N;
        }
    }
    else
    {
        printf "The histogram is too %s to print on a single screen\n",
                $columns > $MAX_COLUMNS ? 'wide' : 'tall';
    }
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    scalar @ARGV > 0        or die "ERROR: Missing command-line arguments\n" .
                                          "$USAGE";
    for (@ARGV)
    {
        /\A$RE{num}{int}\z/ or die "ERROR: Non-integer '$_'\n$USAGE";
        $_ >= 0             or die "ERROR: $_ is negative\n$USAGE";
    }

    return @ARGV;
}

###############################################################################
