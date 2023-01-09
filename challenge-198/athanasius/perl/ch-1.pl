#!perl

###############################################################################
=comment

Perl Weekly Challenge 198
=========================

TASK #1
-------
*Max Gap*

Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to find the total pairs in the sorted list where 2 consecutive
elements has the max gap. If the list contains less then 2 elements then return
0.

Example 1

  Input:  @list = (2,5,8,1)
  Output: 2

  Since the sorted list (1,2,5,8) has 2 such pairs (2,5) and (5,8)

Example 2

  Input: @list = (3)
  Output: 0

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
1. If no command-line arguments are given, the test suite is run.
2. If $VERBOSE is set to a true value, an explanation like that in Example 1 is
   added to the solution.

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );
use Test::More;

const my $TEST_FIELDS => 3;
const my $VERBOSE     => 1;
const my $USAGE       =>
"Usage:
  perl $0 [<list> ...]
  perl $0

    [<list> ...]    A list of 1 or more integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 198, Task #1: Max Gap (Perl)\n\n";
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
        my @list = @ARGV;

        for (@list)
        {
            / ^ $RE{num}{int} $ /x
                or die qq[ERROR: "$_" is not a valid integer\n$USAGE];
        }

        printf "Input:  \@list = (%s)\n", join ', ', @list;

        my ($max_pairs, $max_gap, $pairs) = max_gap( @list );

        print  "Output: $max_pairs\n";

        if ($VERBOSE && scalar @list > 1)
        {
            printf "\nSince the sorted list (%s) has %d pair%s with the " .
                   "maximum gap of %d:\n%s\n",
                    join( ',', sort { $a <=> $b } @list ),
                    $max_pairs,
                   ($max_pairs == 1 ? '' : 's'),
                    $max_gap,
                    join( ', ', map { '(' . join( ',', @$_ ) . ')' } @$pairs );
        }
    }
}

#------------------------------------------------------------------------------
sub max_gap
#------------------------------------------------------------------------------
{
    my  @list   = @_;
    my  @sorted = sort { $a <=> $b } @list;
    my ($max_gap, $max_pairs, @pairs) = (-1, 0, ());

    for my $i (0 .. $#sorted - 1)
    {
        my $gap = $sorted[ $i + 1 ] - $sorted[ $i ];

        if    ($gap >  $max_gap)
        {
            $max_gap   = $gap;
            $max_pairs = 1;
            @pairs     = [ @sorted[ $i, $i + 1 ] ];
        }
        elsif ($gap == $max_gap)
        {
            ++$max_pairs;
            push @pairs, [ @sorted[ $i, $i + 1 ] ];
        }
    }    

    return ($max_pairs, $max_gap, \@pairs);
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $input, $expected) = split /\|/, $line, $TEST_FIELDS;

        $input    =~ s/ ^ \s* (.+?) \s* $ /$1/x;              # Trim whitespace
        $expected =~ s/ ^ \s* (.+?) \s* $ /$1/x;
        $expected =~ s/   \s+             / /gx;

        my  @list = split / , \s+ /x, $input;

        my ($max_pairs, undef, undef) = max_gap( @list );

        my  $got  = join ', ', $max_pairs;

        is  $got, $expected, $test_name;
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1| 2,  5,  8,  1   |2
Example 2| 3               |0
Negatives|-5, -1, -3       |2
Mixed    |-3,  4,  2, -1, 1|3
