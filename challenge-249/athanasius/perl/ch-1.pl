#!perl

################################################################################
=comment

Perl Weekly Challenge 249
=========================

TASK #1
-------
*Equal Pairs*

Submitted by: Mohammad S Anwar

You are given an array of integers with even number of elements.

Write a script to divide the given array into equal pairs such that:

  a) Each element belongs to exactly one pair.
  b) The elements present in a pair are equal.

Example 1

  Input: @ints = (3, 2, 3, 2, 2, 2)
  Output: (2, 2), (3, 3), (2, 2)

  There are 6 elements in @ints.
  They should be divided into 6 / 2 = 3 pairs.
  @ints is divided into the pairs (2, 2), (3, 3), and (2, 2) satisfying all the
  conditions.

Example 2

  Input: @ints = (1, 2, 3, 4)
  Output: ()

  There is no way to divide @ints 2 pairs such that the pairs satisfy every
  condition.

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

Algorithm
---------

=cut
#===============================================================================

use v5.32.1;       # Enables strictures
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $USAGE =>
"Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    An even-numbered list of integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 248, Task #1: Equal Pairs (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    my  $argc = scalar @ARGV;

    if ($argc == 0)
    {
        run_tests();
    }
    else
    {
        $argc % 2 == 0
                or error( "Expected an even number of integers, found $argc" );

        my @ints = @ARGV;

        for (@ints)
        {
            / ^ $RE{num}{int} $ /x
                or error( qq[Element "$_" is not a valid integer] );
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $pairs = find_equal_pairs( \@ints );

        printf "Output: %s\n",
              @$pairs ? join ', ', map { '(' . join( ', ', @$_ ) . ')' } @$pairs
                      : '()';
    }
}

#-------------------------------------------------------------------------------
sub find_equal_pairs
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  @pairs;
    my  @sorted = sort { $a <=> $b } @$ints;

    while (@sorted)
    {
        my $pair = [ shift @sorted, shift @sorted ];

        if ($pair->[ 0 ] == $pair->[ 1 ])
        {
            push @pairs, $pair;
        }
        else    # No solution is possible
        {
            @pairs = ();
            last;
        }
    }

    return \@pairs;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints_str, @exp_pair_strs) = split / \| /x, $line;

        for ($test_name, $ints_str, @exp_pair_strs)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints  = split / \s+ /x, $ints_str;
        my $pairs = find_equal_pairs( \@ints );
        my @expected;

        for (@exp_pair_strs)
        {
            push @expected, [ split / \s+ /x ] if $_;
        }

        is_deeply $pairs, \@expected, $test_name;
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
Example 1  | 3 2 3  2 2 2          | 2  2| 2  2|3 3
Example 2  | 1 2 3  4              |
Negatives 1|-1 1 3 -1 3 1 -1 -1    |-1 -1|-1 -1|1 1|3 3
Negatives 2|-1 1 3 -1 3 1 -1 -1 0 1|
