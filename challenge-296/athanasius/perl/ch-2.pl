#!perl

################################################################################
=comment

Perl Weekly Challenge 296
=========================

TASK #2
-------
*Matchstick Square*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.

Write a script to find if it is possible to make one square using the sticks as
in the given array @ints where $ints[ì] is the length of ith stick.

Example 1

  Input: @ints = (1, 2, 2, 2, 1)
  Output: true

  Top: $ints[1] = 2
  Bottom: $ints[2] = 2
  Left: $ints[3] = 2
  Right: $ints[0] and $ints[4] = 2

Example 2

  Input: @ints = (2, 2, 2, 4)
  Output: false

Example 3

  Input: @ints = (2, 2, 2, 2, 4)
  Output: false

Example 4

  Input: @ints = (3, 4, 1, 4, 3, 1)
  Output: true

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
In forming the square, each matchstick must be used exactly once.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A non-empty list of positive (non-zero) integers is entered on the command-
   line.
3. If $VERBOSE is set to a true value, an output of "true" is followed by
   details of the makeup of each side of the square.

Algorithm
---------
Beginning with the longest matchstick and working down to the shortest, each
stick is placed in the first available side, and so on recursively until either
all sides are filled (success) or further progress is impossible. In the latter
case, the algorithm backtracks to the most recent placement, and the next
possible placement is tried. When all possible placements have been tried with-
out success, the algorithm returns failure.

=cut
#===============================================================================

use v5.32;         # Enables strictures and warnings
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of positive (non-zero) integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 296, Task #2: Matchstick Square (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    if (scalar @ARGV == 0)
    {
        run_tests();
    }
    else
    {
        my @ints = @ARGV;

        for (@ints)
        {
            / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
            $_ > 0                 or error( "$_ is not positive" );
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my @sides;
        my $result = make_square( \@ints, \@sides );

        printf "Output: %s\n", $result ? 'true' : 'false';

        if ($VERBOSE && $result)
        {
            printf "\nTop:    %s\n", join ' + ', $sides[ 0 ]->@*;
            printf   "Bottom: %s\n", join ' + ', $sides[ 1 ]->@*; 
            printf   "Left:   %s\n", join ' + ', $sides[ 2 ]->@*;
            printf   "Right:  %s\n", join ' + ', $sides[ 3 ]->@*;
        }
    }
}

#-------------------------------------------------------------------------------
sub make_square
#-------------------------------------------------------------------------------
{
    my ($ints, $sides) = @_;
       @$sides  = ([], [], [], []);
    my  $result = 0;
    my  $sum    = 0;
        $sum   += $_ for @$ints;

    if ($sum % 4 == 0)
    {
        my $target = int( $sum / 4 );
        my @sticks = sort { $b <=> $a } @$ints;

        if ($sticks[ 0 ] <= $target)
        {
            $result = add_stick( $sides, \@sticks, $target );
        }
    }

    return $result;
}

#-------------------------------------------------------------------------------
sub add_stick                                             # Recursive subroutine
#-------------------------------------------------------------------------------
{
    my ($sides, $sticks, $target) = @_;

    if (solved( $sides, $target ))
    {
        scalar @$sticks == 0 or die 'Not all sticks used';

        return 1;                            # Base case 1: Solved
    }

    return 0 if scalar @$sticks == 0;        # Base case 2: No more sticks

    my $stick = shift @$sticks;                                 # Reductive step

    for my $i (get_sides_to_try( $sides, $target, $stick ))
    {
        push $sides->[ $i ]->@*, $stick;

        return 1 if add_stick( $sides, $sticks, $target );      # Recursive call

        pop  $sides->[ $i ]->@*;
    }

    return 0;                                # Base case 3: No more sides to try
}

#-------------------------------------------------------------------------------
sub get_sides_to_try
#-------------------------------------------------------------------------------
{
    my ($sides, $target, $stick) = @_;
    my  @sides_to_try;

    for my $i (0 .. 3)
    {
        my $sum  = 0;
           $sum += $_ for $sides->[ $i ]->@*;
        my $diff = $target - $sum;

        push @sides_to_try, $i if $stick <= $diff;
    }

    return @sides_to_try;
}

#-------------------------------------------------------------------------------
sub solved
#-------------------------------------------------------------------------------
{
    my ($sides, $target) = @_;

    for my $i (0 .. 3)
    {
        my $sum  = 0;
           $sum += $_ for $sides->[ $i ]->@*;

        return 0 unless $sum == $target;
    }

    return 1;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, @expected_strs) = split / \| /x, $line;

        for ($test_name, $ints_str, @expected_strs)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints = split / \s+ /x, $ints_str;
        my @sides;

        make_square( \@ints, \@sides );

        my @expected = ([], [], [], []);

        if (length $expected_strs[ 0 ] > 0)
        {
            my $i = 0;

            push $expected[ $i++ ]->@*, split / \s+ /x for @expected_strs;
        }

        is_deeply \@sides, \@expected, $test_name;
    }

    done_testing;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################

__DATA__
Example 1     |1 2 2 2 1                 |2|2|2|1 1
Example 2     |2 2 2 4                   |
Example 3     |2 2 2 2 4                 |
Example 4     |3 4 1 4 3 1               |4|4|3 1|3 1
No more sticks|6 1 1 5 3 4  4            |
Doesn't fit   |2   2 3 5 5 10 13 15 26 27|
Does fit      |1 1 2 3 5 5 10 13 15 26 27|27|26 1|15 10 2|13 5 5 3 1
