#!perl

###############################################################################
=comment

Perl Weekly Challenge 196
=========================

TASK #1
-------
*Pattern 132*

Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to find out subsequence that respect Pattern 132. Return empty
array if none found.

    Pattern 132 in a sequence (a[i], a[j], a[k]) such that i < j < k and a[i] <
    a[k] < a[j].

Example 1

  Input:  @list = (3, 1, 4, 2)
  Output: (1, 4, 2) respect the Pattern 132.

Example 2

  Input: @list = (1, 2, 3, 4)
  Output: () since no susbsequence can be found.

Example 3

  Input: @list = (1, 3, 2, 4, 6, 5)
  Output: (1, 3, 2) if more than one subsequence found then return the first.

Example 4

  Input: @list = (1, 3, 4, 2)
  Output: (1, 3, 2)

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

=cut
#==============================================================================

use v5.32;
use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $TEST_FLDS => 3;
const my $USAGE     =>
"Usage:
  perl $0 [<list> ...]
  perl $0

    [<list> ...]    A list of 3 or more integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 196, Task #1: Pattern 132 (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $args = scalar @ARGV;

    if    ($args == 0)
    {
        run_tests();
    }
    elsif ($args <  3)
    {
        error( "Expected 0 or 3+ command-line arguments, found $args" );
    }
    else
    {
        my @list = parse_command_line();

        printf "Input:  \@list = (%s)\n", join ', ',              @list;
        printf "Output: (%s)\n",          join ', ', pattern_132( @list );
    }
}

#------------------------------------------------------------------------------
sub pattern_132
#------------------------------------------------------------------------------
{
    my @list = @_;
    my @pattern;

    OUTER:
    for my $i (0 .. $#list - 2)
    {
        for my $j ($i + 1 .. $#list - 1)
        {
            next unless $list[ $i ] < $list[ $j ];

            for my $k ($j + 1 .. $#list)
            {
                if ($list[ $i ] < $list[ $k ] < $list[ $j ])
                {
                    @pattern = @list[ $i, $j, $k ];
                    last OUTER;
                }
            }
        }
    }

    return @pattern;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my @list = @ARGV;

    for (@list)
    {
        / ^ $RE{num}{int} $ /x or error( qq["$_" is not a valid integer] );
    }

    return @list;
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

        my ($test_name, $input, $expected) = split / \| /x, $line, $TEST_FLDS;

        $input    =~ s/ ^ \s* (.+) \s* $ /$1/x;               # Trim whitespace
        $expected =~ s/ ^ \s* (.+) \s* $ /$1/x;

        my @list = split / \s+ /x, $input;
        my $got  = join ', ', pattern_132( @list );

        is $got, $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1| 3  1 4 2    | 1, 4, 2
Example 2| 1  2 3 4    |
Example 3| 1  3 2 4 6 5| 1, 3, 2
Example 4| 1  3 4 2    | 1, 3, 2
Negatives|-1 -2 1 0    |-1, 1, 0
