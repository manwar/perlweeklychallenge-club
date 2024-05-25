#!perl

################################################################################
=comment

Perl Weekly Challenge 270
=========================

TASK #2
-------
*Equalize Array*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints and two integers, $x and $y.

Write a script to execute one of the two options:

  Level 1:
  Pick an index i of the given array and do $ints[i] += 1

  Level 2:
  Pick two different indices i,j and do $ints[i] +=1 and $ints[j] += 1.

You are allowed to perform as many levels as you want to make every elements in
the given array equal. There is cost attached for each level, for Level 1, the
cost is $x and $y for Level 2.

In the end return the minimum cost to get the work done.

Example 1

  Input: @ints = (4, 1), $x = 3 and $y = 2
  Output: 9

  Level 1: i=1, so $ints[1] += 1.
  @ints = (4, 2)

  Level 1: i=1, so $ints[1] += 1.
  @ints = (4, 3)

  Level 1: i=1, so $ints[1] += 1.
  @ints = (4, 4)

  We performed operation Level 1, 3 times.
  So the total cost would be 3 x $x => 3 x 3 => 9

Example 2

  Input: @ints = (2, 3, 3, 3, 5), $x = 2 and $y = 1
  Output: 6

  Level 2: i=0, j=1, so $ints[0] += 1 and $ints[1] += 1
  @ints = (3, 4, 3, 3, 5)

  Level 2: i=0, j=2, so $ints[0] += 1 and $ints[2] += 1
  @ints = (4, 4, 4, 3, 5)

  Level 2: i=0, j=3, so $ints[0] += 1 and $ints[3] += 1
  @ints = (5, 4, 4, 4, 5)

  Level 2: i=1, j=2, so $ints[1] += 1 and $ints[2] += 1
  @ints = (5, 5, 5, 4, 5)

  Level 1: i=3, so $ints[3] += 1
  @ints = (5, 5, 5, 5, 5)

  We performed operation Level 1, 1 time and Level 2, 4 times.
  So the total cost would be (1 x $x) + (3 x $y) => (1 x 2) + (4 x 1) => 6

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
Costs cannot be negative.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. The costs $x and $y are entered as named arguments on the command-line,
   followed by the elements of @ints; e.g.

        perl ch-2.pl -x 3 -y 2 4 1

3. If @ints contains negative numbers, they must be preceded by "--" to prevent
   them from being interpreted as command-line flags; e.g.

        perl ch-2.pl -x 5 -y 3 -- -1 -2 -3 -6

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Getopt::Long;
use List::Util     qw( max );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [-x[=UInt]] [-y[=UInt]] [<ints> ...]
  perl $0

    -x[=UInt]       Cost of Level 1 option
    -y[=UInt]       Cost of Level 2 option
    [<ints> ...]    List of one or more integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 270, Task #2: Equalize Array (Perl)\n\n";
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
        my ($x, $y, $ints) = parse_command_line();

        printf "Input:  \@ints = (%s), \$x = %d and \$y = %d\n",
                join( ', ', @$ints ), $x, $y;

        my $cost = find_min_cost( $ints, $x, $y );

        print  "Output: $cost\n";
    }
}

#-------------------------------------------------------------------------------
sub find_min_cost
#-------------------------------------------------------------------------------
{
    my ($ints, $x, $y) = @_;
    my  $cost = 0;

    if ($x > 0)   # Otherwise array can be equalized with all Level 1 at no cost
    {
        my $max = max @$ints;

        if ($y < 2 * $x)     # Otherwise Level 2 gives no advantage over Level 1
        {
            # First, apply Level 2 as often as possible

            L_OUTER:
            for my $i (0 .. $#$ints - 1)
            {
                for my $j ($i + 1 .. $#$ints)
                {
                    if ($ints->[ $i ] < $max && $ints->[ $j ] < $max)
                    {
                        ++$ints->[ $i ];
                        ++$ints->[ $j ];

                        $cost += $y;

                        redo L_OUTER;
                    }
                }
            }
        }

        # Now complete array equalization with Level 1

        $cost += ($max - $_) * $x for @$ints;
    }

    return $cost;
}

#-------------------------------------------------------------------------------
sub parse_command_line
#-------------------------------------------------------------------------------
{
    my ($x, $y);

    GetOptions
    (
        'x=i' => \$x,
        'y=i' => \$y
    )                          or error( 'Invalid command-line arguments' );

    defined $x                 or error( 'Missing $x' );
    defined $y                 or error( 'Missing $y' );

    my @ints = @ARGV;

    scalar @ints > 0           or error( 'Missing @ints' );

    for ($x, $y, @ints)
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
    }

    for ($x, $y)
    {
        $_ >= 0                or error( "$_ is an invalid cost" );
    }

    return ($x, $y, \@ints);
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, $x, $y, $expected) = split / \| /x, $line;

        for ($test_name, $ints_str, $x, $y, $expected)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints = split / \s+ /x, $ints_str;
        my $cost = find_min_cost( \@ints, $x, $y );

        is $cost, $expected, $test_name;
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
Example 1| 4  1        |3|2| 9
Example 2| 2  3  3  3 5|2|1| 6
Zero x   | 2  3  3  3 5|0|1| 0
Zero y   | 2  3  3  3 5|7|0| 7
Uniform  | 4  4  4  4  |2|1| 0
Negatives|-1 -2 -3 -6  |5|3|26|     # 2×3 + 4×5
Singleton|17           |3|2| 0
