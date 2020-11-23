#!perl

###############################################################################
=comment

Perl Weekly Challenge 087
=========================

Task #1
-------
*Longest Consecutive Sequence*

Submitted by: Mohammad S Anwar

You are given an unsorted array of integers @N.

Write a script to find the longest consecutive sequence. Print 0 if none
sequence found.

Example 1:

 Input: @N = (100, 4, 50, 3, 2)
 Output: (2, 3, 4)

Example 2:

 Input: @N = (20, 30, 10, 40, 50)
 Output: 0

Example 3:

 Input: @N = (20, 19, 9, 11, 10)
 Output: (9, 10, 11)

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

From the Examples, it appears that a "sequence" is an ordered set of TWO or
more integers in which adjacent numbers differ by exactly 1. It is assumed that
any duplicates in the input array are irrelevant to the solution and may be
ignored.

The algorithm used:
    1. Sort the input array in increasing numerical order.
    2. Create a list of sequences (an AoA) as follows: put the first element
       into a new sequence, and then, for each succeeding element, either:
       a. ignore it because it is equal to the previous element; or
       b. add it to the current sequence because it is exactly one greater than
          the last element added to that sequence; or
       c. use it to start a new sequence.
    3. Find the longest sequence. If its length is 2 or more, output it, other-
       wise output "0".

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Regexp::Common qw( number );

const my $USAGE =>
"Usage:
  perl $0 [<N> ...]

    [<N> ...]    A non-empty, unsorted array of integers\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 087, Task #1: Longest Consecutive Sequence (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my @N = parse_command_line();

    printf "Input:  \@N = (%s)\n", join ', ', @N;

    my @sequences   = find_sequences( @N );
    my @longest_seq = get_longest_seq(@sequences);

    if (scalar @longest_seq <= 1)
    {
        print "Output: 0\n";
    }
    else
    {
        printf "Output: (%s)\n", join ', ', @longest_seq;
    }
}

#------------------------------------------------------------------------------
sub find_sequences
#------------------------------------------------------------------------------
{
    my @N     = sort { $a <=> $b } @_;
    my $prev  = shift @N;
    my @seqs  = [ $prev ];
    my $index = 0;

    for my $current (@N)
    {
        next if $current == $prev;

        if ($current == $prev + 1)
        {
            push $seqs[ $index ]->@*, $current;
        }
        else
        {
            $seqs[ ++$index ] = [ $current ];
        }

        $prev = $current;
    }

    return @seqs;
}

#------------------------------------------------------------------------------
sub get_longest_seq
#------------------------------------------------------------------------------
{
    my @seqs      = @_;
    my $max_count = 0;
    my @max_seq;

    for my $seq (@seqs)
    {
        my $count = scalar @$seq;

        if ($count > $max_count)
        {
            $max_count = $count;
            @max_seq   = @$seq;
        }
    }

    return @max_seq;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my @N = @ARGV;

    scalar @N > 0             or die qq[ERROR: Empty array\n$USAGE];

    for (@N)
    {
        /\A$RE{num}{int}\z/   or die qq[ERROR: "$_" is not an integer\n$USAGE];
    }

    return @N;
}

###############################################################################
