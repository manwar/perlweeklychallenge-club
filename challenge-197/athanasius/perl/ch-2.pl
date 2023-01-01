#!perl

###############################################################################
=comment

Perl Weekly Challenge 197
=========================

TASK #2
-------
*Wiggle Sort*

Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to perform Wiggle Sort on the given list.


    Wiggle sort would be such as list[0] < list[1] > list[2] < list[3]….


Example 1

  Input: @list = (1,5,1,1,6,4)
  Output: (1,6,1,5,1,4)

Example 2

  Input: @list = (1,3,2,2,3,1)
  Output: (2,3,1,3,1,2)

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2023 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
If no command-line arguments are given, the test suite is run.

Notes
-----
1. 'Wiggle sort' is also known as 'wave sort'.
2. If no solution is possible for a given input, the output is '()', which
   represents the empty list.
3. The solution algorithm is described in [1].
4. The algorithm for determining whether a given input list is wiggle-sortable
   (by counting "medians") is given in [1], corrected in [2].

References
----------
[1] John L., Answer to "How to wiggle sort an array in linear time complex-
    ity?", Computer Science Stack Exchange (8 May, 2020), https://cs.stack
    exchange.com/questions/125372/how-to-wiggle-sort-an-array-in-linear-time-
    complexity

[2] John L, Answer to "How to find wiggle sortable arrays? Did I misunderstand
    John L.s' answer?" Computer Science Stack Exchange (25 April, 2022),
    https://cs.stackexchange.com/questions/150886/how-to-find-wiggle-sortable-
    arrays-did-i-misunderstand-john-l-s-answer

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use POSIX          qw( ceil );
use Regexp::Common qw( number );
use Test::More;

const my $TEST_FIELDS => 3;
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
    print "\nChallenge 197, Task #2: Wiggle Sort (Perl)\n\n";
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

        printf "Input:  \@list = (%s)\n", join ', ',              @list;
        printf "Output:         (%s)\n",  join ', ', wiggle_sort( @list );
    }
}

#------------------------------------------------------------------------------
sub wiggle_sort
#------------------------------------------------------------------------------
{
    my @list   = @_;
    my @sorted = ();

    if (is_wiggle_sortable( @list ))
    {
        @list = sort { $a <=> $b } @list;

        my $max_i = $#list;

        for my $i (1 .. $max_i)
        {
            next  if $i % 2 == 0;
            $sorted[ $i ] = pop @list;
        }

        for my $j (0 .. $max_i)
        {
            next  if $j % 2 == 1;
            $sorted[ $j ] = pop @list;
        }

        is_wiggle_sorted( @sorted ) or die 'Wiggle sort failed';
    }

    return @sorted;
}

#------------------------------------------------------------------------------
sub is_wiggle_sortable
#------------------------------------------------------------------------------
{
    # Count "medians" (see [1] as corrected in [2])

    my @list  = sort { $a <=> $b } @_;          # 1. Sort the list
    my $n     = scalar @list;                   # 2. Find m, the ⌈n/2⌉-th entry
    my $n2    = ceil( $n / 2 );
    my $m     = $list[ $n2 - 1 ];
    my $count = 0;                              # 3. Count entries equal to m
    $_ == $m && ++$count for @list;

    # 4. "The number of medians of A is no more than ⌈n/2⌉. Furthermore, if n
    #     is odd and the number of medians is ⌈n/2⌉, the median must be the
    #     smallest number of A." -- [2], with typo corrected

    return ($count > $n2) ? 0 :
           ($count < $n2) ? 1 :
           ($n % 2 == 1)  ? ($m == $list[ 0 ]) : 1;
}

#------------------------------------------------------------------------------
sub is_wiggle_sorted
#------------------------------------------------------------------------------
{
    my @list = @_;

    for my $i (0 .. $#list - 1)
    {
        if ($i % 2 == 0)
        {
            return 0 unless $list[ $i ] < $list[ $i + 1 ];
        }
        else
        {
            return 0 unless $list[ $i ] > $list[ $i + 1 ];
        }
    }

    return 1;
}

#------------------------------------------------------------------------------
sub run_tests
#------------------------------------------------------------------------------
{
    print "Running the test suite\n";

    while (my $line = <DATA>)
    {
        chomp $line;

        my ($test_name, $input, $expected) =
            split / \| /x, $line, $TEST_FIELDS;

        s/ ^ \s* (.+?) \s* $ /$1/x                            # Trim whitespace
            for $test_name, $input, $expected;

        my @list   = split / , /x, $input;
        my @sorted = wiggle_sort( @list );
        my $got    = join ',', @sorted;

        ok( is_wiggle_sorted( @sorted ), $test_name ) if $expected;
        is( $got, $expected, $test_name );
    }

    done_testing;
}

###############################################################################

__DATA__
Example 1   |1,5,1,1,6,4|1,6,1,5,1,4
Example 2   |1,3,2,2,3,1|2,3,1,3,1,2
Short       |2,1,1      |1,2,1
Not sortable|1,2,2      |
Distinct    |5,4,3,2,1,0|2,5,1,4,0,3
Single      |42         |42
Negatives   |-1,-2,-3,-4|-3,-1,-4,-2
