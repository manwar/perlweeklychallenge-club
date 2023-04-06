#!perl

################################################################################
=comment

Perl Weekly Challenge 210
=========================

TASK #2
-------
*Number Collision*

Submitted by: Mohammad S Anwar

You are given an array of integers which can move in right direction if it is
positive and left direction when negative. If two numbers collide then the
smaller one will explode. And if both are same then they both explode. We take
the absolute value in consideration when comparing.

All numbers move at the same speed, therefore any 2 numbers moving in the same
direction will never collide.

Write a script to find out who survives the collision.

Example 1:

  Input: @list = (2, 3, -1)
  Output: (2, 3)

  The numbers 3 and -1 collide and -1 explodes in the end. So we are left with
  (2, 3).

Example 2:

  Input: @list = (3, 2, -4)
  Output: (-4)

  The numbers 2 and -4 collide and 2 explodes in the end. That gives us (3, -4).
  Now the numbers 3 and -4 collide and 3 explodes. Finally we are left with -4.

Example 3:

  Input: @list = (1, -1)
  Output: ()

  The numbers 1 and -1 both collide and explode. Nothing left in the end.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Assumptions
-----------
1. All movement occurs in a single dimension.
2. The order in which the integers appear in the array is the same (left-to-
   right) order in which they are arranged, relative to each other, in one-
   dimensional space.
3. A value of 0 (zero) is unmoving. (And, of course, if anything collides with a
   0, the 0 explodes.)

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use List::Util     qw( any );
use Regexp::Common qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<list> ...]
  perl $0

    [<list> ...]    A list of integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 210, Task #2: Number Collision (Perl)\n\n";
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
        my @list = @ARGV;

        for (@list)
        {
            / ^ $RE{num}{int} $ /x
                or die qq[ERROR: "$_" is not a valid integer\n$USAGE];
        }

        printf "Input:  \@list = (%s)\n", join ', ', @list;

        my @survivors = find_survivors( \@list );

        printf "Output: (%s)\n",          join ', ', @survivors;
    }
}

#-------------------------------------------------------------------------------
sub find_survivors
#-------------------------------------------------------------------------------
{
    my ($list)  = @_;
    my  @middle = @$list;
    my (@left,    @right);

    while (any { defined( $_ ) && abs( $_ ) > 0 } @middle)
    {
        push    @left,  shift @middle
            while defined $middle[  0 ] && $middle[  0 ] < 0;

        unshift @right, pop   @middle
            while defined $middle[ -1 ] && $middle[ -1 ] > 0;

        my @next = (undef) x scalar @middle;

        move_left ( \@middle, \@next );
        move_right( \@middle, \@next );

        @middle = @next;
    }

    return grep { defined } @left, @middle, @right;
}

#-------------------------------------------------------------------------------
sub move_left
#-------------------------------------------------------------------------------
{
    my ($middle, $next) = @_;

    for my $i (0 .. $#$middle)
    {
        if (defined( my $elem0 = $middle->[ $i ] ))
        {
            if    ($elem0 == 0)     # Unmoving
            {
                $next->[ $i ] = 0;
            }
            elsif ($elem0 <  0)     # Moving left
            {
                if (defined( my $elem1 = $middle->[ $i - 1 ] ))
                {
                    if    (abs $elem0 > $elem1)
                    {
                        $middle->[ $i - 1 ] = undef;
                        $next  ->[ $i - 1 ] = $elem0;
                    }
                    elsif (abs $elem0 == $elem1)
                    {
                        $middle->[ $i - 1 ] = undef;
                    }
                }
                else
                {
                    $middle->[ $i - 1 ] = undef;
                    $next  ->[ $i - 1 ] = $elem0;
                }
            }
        }
    }
}

#-------------------------------------------------------------------------------
sub move_right
#-------------------------------------------------------------------------------
{
    my ($middle, $next) = @_;

    for my $i (reverse 0 .. $#$middle)
    {
        my $elem0 = $middle->[ $i ];

        if (defined $elem0 && $elem0 > 0)         # Moving right
        {
            if (defined( my $elem1 = $next->[ $i + 1 ] ))
            {
                if    ($elem0 == abs $elem1)
                {
                    $next->[ $i + 1 ] = undef;
                }
                elsif ($elem0 >  abs $elem1)
                {
                    $next->[ $i + 1 ] = $elem0;
                }
            }
            else
            {
                $next->[ $i + 1 ] = $elem0;
            }
        }
    }
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $input, $output) = split / \| /x, $line;

        $input  =~ s/ ^ \s+   //gx;     # Trim whitespace
        $input  =~ s/   \s+ $ //gx;
        $output =~ s/ ^ \s+   //gx;
        $output =~ s/   \s+ $ //gx;

        my @list     = split / , \s* /x, $input;
        my @got      = find_survivors( \@list );
        my @expected = split / , \s* /x, $output;

        is_deeply \@got, \@expected, $test_name;
    }

    done_testing;
}

################################################################################

__DATA__
Example 1         | 2,  3, -1             | 2, 3
Example 2         | 3,  2, -4             |-4
Example 3         | 1, -1                 |
No collision      |-2,  1                 |-2, 1
Adjacent collision| 2, -3                 |-3
Meet in the middle| 4,  0, -3             | 4
Combination       |-7,  2, -3, 4, 0, -3, 8|-7, -3, 4, 8
