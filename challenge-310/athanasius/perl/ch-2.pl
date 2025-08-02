#!perl

################################################################################
=comment

Perl Weekly Challenge 310
=========================

TASK #2
-------
*Sort Odd Even*

Submitted by: Mohammad Sajid Anwar

You are given an array of integers.

Write a script to sort odd index elements in decreasing order and even index 
elements in increasing order in the given array.

Example 1

  Input: @ints = (4, 1, 2, 3)
  Output: (2, 3, 4, 1)

  Even index elements: 4, 2 => 2, 4 (increasing order)
  Odd index elements : 1, 3 => 3, 1 (decreasing order)

Example 2

  Input: @ints = (3, 1)
  Output: (3, 1)

Example 3

  Input: @ints = (5, 3, 2, 1, 4)
  Output: (2, 3, 4, 1, 5)

  Even index elements: 5, 2, 4 => 2, 4, 5 (increasing order)
  Odd index elements : 3, 1 => 3, 1 (decreasing order)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2025 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Assumption
----------
The given array contains at least one integer.

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. A list of 1 or more integers is entered on the command-line.

=cut
#===============================================================================

use v5.32;          # Enables strictures and warnings
use Const::Fast;
use List::MoreUtils qw( mesh );
use Regexp::Common  qw( number );
use Test::More;

const my $USAGE => <<END;
Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A list of one or more integers
END

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 310, Task #2: Sort Odd Even (Perl)\n\n";
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

        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] )
            for @ints;

        printf "Input: \@ints = (%s)\n", join ', ', @ints;

        my $sorted = sort_odd_even( \@ints );

        printf "Output:        (%s)\n",  join ', ', @$sorted;
    }
}

#-------------------------------------------------------------------------------
sub sort_odd_even
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my (@odd, @even);

    while (@$ints)
    {
        push @even, shift @$ints;
        push @odd,  shift @$ints if scalar @$ints > 0;
    }

    @even = sort { $a <=> $b } @even;           # Increasing
    @odd  = sort { $b <=> $a } @odd;            # Decreasing

    my  @sorted = mesh @even, @odd;
    pop @sorted unless defined $sorted[ -1 ];

    return \@sorted;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $int_str, $exp_str) = split / \| /x, $line;

        for ($test_name, $int_str, $exp_str)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints     = split / \s+ /x, $int_str;
        my $sorted   = sort_odd_even( \@ints );
        my @expected = split / \s+ /x, $exp_str;

        is_deeply $sorted, \@expected, $test_name;
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
Example 1|4 1 2 3  |2 3 4 1
Example 2|3 1      |3 1
Example 3|5 3 2 1 4|2 3 4 1 5
