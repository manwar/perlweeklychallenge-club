#!perl

################################################################################
=comment

Perl Weekly Challenge 220
=========================

TASK #2
-------
*Squareful*

Submitted by: Mohammad S Anwar

You are given an array of integers, @ints.

    An array is squareful if the sum of every pair of adjacent elements is a
    perfect square.

Write a script to find all the permutations of the given array that are square-
ful.

Example 1:

  Input: @ints = (1, 17, 8)
  Output: (1, 8, 17), (17, 8, 1)

  (1, 8, 17) since 1 + 8 => 9, a perfect square and also 8 + 17 => 25 is perfect
             square too.
  (17, 8, 1) since 17 + 8 => 25, a perfect square and also 8 + 1 => 9 is perfect
             square too.

Example 2:

  Input: @ints = (2, 2, 2)
  Output: (2, 2, 2)

  There is only one permutation possible.

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

=cut
#===============================================================================

use strict;
use warnings;
use Algorithm::Loops qw( NextPermuteNum );
use Const::Fast;
use Regexp::Common   qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A non-empty list of integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 220, Task #2: Squareful (Perl)\n\n";
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
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
            for @ARGV;

        printf "Input:  \@ints = (%s)\n", join ', ', @ARGV;

        my $perms = find_squareful_permutations( \@ARGV );

        printf "Output: %s\n",
                join ', ', map { '(' . join( ', ', @$_ ) . ')' } @$perms;
    }
}

#-------------------------------------------------------------------------------
sub find_squareful_permutations
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  @perm  = sort { $a <=> $b } @$ints;
    my  @squareful_perms;

    do
    {
        L_OUTER:
        {
            for my $i (0 .. $#perm - 1)
            {
                my $sum = $perm[ $i ] + $perm[ $i + 1 ];

                next L_OUTER unless sqrt( $sum ) ** 2 == $sum;  # Perfect square
            }

            push @squareful_perms, [ @perm ];
        }

    } while (NextPermuteNum( @perm ));

    return \@squareful_perms;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($name, $ints_str, @expected_strs) = split / \| /x, $line;

        for ($name, $ints_str, @expected_strs)                 # Trim whitespace
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints  = split / \s+ /x, $ints_str;
        my $perms = find_squareful_permutations( \@ints );
        my @expected;

        for (@expected_strs)
        {
            my   @ints = split / \s+ /x;
            push @expected, \@ints if scalar @ints > 0 && length $ints[ 0 ] > 0;
        }

        is_deeply $perms, \@expected, $name;
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
Example 1   |1 17  8|1  8 17|17  8 1
Example 2   |2  2  2|2  2  2
No solution |1  0  2|
Negative    |5 10 -1|5 -1 10|10 -1 5
Out-of-order|8 17  1|1  8 17|17  8 1
