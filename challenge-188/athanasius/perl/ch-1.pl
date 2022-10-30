#!perl

###############################################################################
=comment

Perl Weekly Challenge 188
=========================

TASK #1
-------
*Divisible Pairs*

Submitted by: Mohammad S Anwar

You are given list of integers @list of size $n and divisor $k.

Write a script to find out count of pairs in the given list that satisfies the
following rules.

  The pair (i, j) is eligible if and only if
  a) 0 <= i < j < len(list)
  b) list[i] + list[j] is divisible by k

Example 1

  Input: @list = (4, 5, 1, 6), $k = 2
  Output: 2

Example 2

  Input: @list = (1, 2, 3, 4), $k = 2
  Output: 2

Example 3

  Input: @list = (1, 3, 4, 5), $k = 3
  Output: 2

Example 4

  Input: @list = (5, 1, 2, 3), $k = 4
  Output: 2

Example 5

  Input: @list = (7, 2, 4, 5), $k = 4
  Output: 1

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
- If no arguments are given on the command line, the test suite is run.
- If one or more arguments are given, the first is taken to be the divisor $k,
  and the remainder (if any) are taken to be the elements of @list.
- If $VERBOSE is set to a true value, the output count of pairs is followed by
  a listing of the pairs themselves.

Note
----
Each (i, j) is a pair of *indices* into the given list.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common;
use Test::More;

const my $TEST_FIELDS => 4;
const my $VERBOSE     => 1;
const my $USAGE       =>
"Usage:
  perl $0 <k> [<list> ...]
  perl $0

     <k>            A non-zero integer divisor
    [<list> ...]    A list of 0 or more integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 188, Task #1: Divisible Pairs (Perl)\n\n";
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
        my ($list, $k) = parse_command_line();

        printf "Input:  \@list = (%s), \$k = %d\n", join( ', ', @$list ), $k;

        my ($count, $pairs) = count_divisible_pairs( $list, $k );

        if ($VERBOSE)
        {
            printf "Output: %d (%s)\n", $count,
                    join ', ', map { '[' . join( ', ', @$_ ) . ']' } @$pairs;
        }
        else
        {
            print  "Output: $count\n";
        }
    }
}

#------------------------------------------------------------------------------
sub count_divisible_pairs
#------------------------------------------------------------------------------
{
    my ($list, $k) = @_;
    my  $n         = scalar @$list;
    my  $count     = 0;
    my  @pairs;

    for my $i (0 .. $n - 1)
    {
        for my $j ($i + 1 .. $n - 1)
        {
            if (($list->[ $i ] + $list->[ $j ]) % $k == 0)
            {
                ++$count;
                push @pairs, [ $i, $j ] if $VERBOSE;
            }
        }
    }

    return ($count, \@pairs);
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my ($k, @list) = @ARGV;

    for my $n ($k,  @list)
    {
        $n =~ / ^ $RE{num}{int} $ /x
                or  error( qq["$n" is not a valid integer] );
    }

    $k == 0     and error( '$k must be non-zero' );

    return (\@list, $k);
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

        my ($test_name, $list, $k, $expected) =
            split / , \s* /x, $line, $TEST_FIELDS;

        my  @data   = split /\s+/, $list;
        my ($count) = count_divisible_pairs( \@data, $k );

        is  $count, $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1,  4 5 1 6, 2, 2
Example 2,  1 2 3 4, 2, 2
Example 3,  1 3 4 5, 3, 2
Example 4,  5 1 2 3, 4, 2
Example 5,  7 2 4 5, 4, 1
Empty list,        , 1, 0
