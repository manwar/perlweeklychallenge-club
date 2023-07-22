#!perl

################################################################################
=comment

Perl Weekly Challenge 226
=========================

TASK #2
-------
*Zero Array*

Submitted by: Mohammad S Anwar

You are given an array of non-negative integers, @ints.

Write a script to return the minimum number of operations to make every element
equal zero.

    In each operation, you are required to pick a positive number less than or
    equal to the smallest element in the array, then subtract that from each
    positive element in the array.

Example 1:

  Input: @ints = (1, 5, 0, 3, 5)
  Output: 3

  operation 1: pick 1 => (0, 4, 0, 2, 4)
  operation 2: pick 2 => (0, 2, 0, 0, 2)
  operation 3: pick 2 => (0, 0, 0, 0, 0)

Example 2:

  Input: @ints = (0)
  Output: 0

Example 3:

  Input: @ints = (2, 1, 4, 0, 3)
  Output: 4

  operation 1: pick 1 => (1, 0, 3, 0, 2)
  operation 2: pick 1 => (0, 0, 2, 0, 1)
  operation 3: pick 1 => (0, 0, 1, 0, 0)
  operation 4: pick 1 => (0, 0, 0, 0, 0)

=cut
################################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run. Otherwise:
2. It $VERBOSE is set to a true value, the operations (pick values) are
   described, as per Examples 1 and 3.

Assumption
----------
A "positive element" is an array value greater than zero.

=cut
#===============================================================================

use strict;
use warnings;
use Const::Fast;
use List::Util     qw( uniqnum );
use Regexp::Common qw( number );
use Test::More;

const my $VERBOSE => 1;
const my $USAGE   =>
"Usage:
  perl $0 [<ints> ...]
  perl $0

    [<ints> ...]    A list of one or more non-negative integers\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 226, Task #2: Zero Array (Perl)\n\n";
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
            $_ >= 0                or error( qq["$_" is negative] );
        }

        printf "Input:  \@ints = (%s)\n", join ', ', @ints;

        my $ops = find_min_ops( \@ints );

        printf "Output: %d\n", scalar @$ops;

        if ($VERBOSE && scalar @$ops > 0)
        {
            print "\n";

            my @list = @ints;

            for my $i (0 .. $#$ops)
            {
                my $pick = $ops->[ $i ];

                @list = map { $_ > 0 ? $_ - $pick : $_ } @list;

                printf "Operation %d: pick %d => (%s)\n",
                        $i + 1, $pick, join ', ', @list;
            }
        }
    }
}

#-------------------------------------------------------------------------------
sub find_min_ops
#-------------------------------------------------------------------------------
{
    my ($ints) = @_;
    my  @ops;
    my  @steps = sort { $a <=> $b } uniqnum @$ints;

    shift @steps while scalar @steps > 0 && $steps[ 0 ] == 0;

    if (scalar @steps > 0)
    {
        push @ops, $steps[ 0 ];

        for my $i (1 .. $#steps)
        {
            push @ops, $steps[ $i ] - $steps[ $i - 1 ];
        }
    }

    return \@ops;
}

#-------------------------------------------------------------------------------
sub run_tests
#-------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my  ($test_name, $ints, $min_ops, $picks) = split / \| /x, $line;

        for ($test_name, $ints, $min_ops, $picks)
        {
            s/ ^ \s+   //x;
            s/   \s+ $ //x;
        }

        my @ints  = split / \s+ /x, $ints;
        my @picks = split / \s+ /x, $picks;
        my $ops   = find_min_ops( \@ints );

        is scalar @$ops,  $min_ops, "$test_name: min ops";
        is_deeply  $ops, \@picks,   "$test_name: picks";
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
Example 1|1 5 0 3 5|3|1 2 2
Example 2|0        |0|
Example 3|2 1 4 0 3|4|1 1 1 1
