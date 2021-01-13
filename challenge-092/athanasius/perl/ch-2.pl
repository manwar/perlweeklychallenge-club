#!perl

###############################################################################
=comment

Perl Weekly Challenge 092
=========================

Task #2
-------
*Insert Interval*

Submitted by: Mohammad S Anwar

You are given a set of sorted non-overlapping intervals and a new interval.

Write a script to merge the new interval to the given set of intervals.

Example 1:

 Input $S = (1,4), (8,10); $N = (2,6)
 Output: (1,6), (8,10)

Example 2:

 Input $S = (1,2), (3,7), (8,10); $N = (5,8)
 Output: (1,2), (3,10)

Example 3:

 Input $S = (1,5), (7,9); $N = (10,11)
 Output: (1,5), (7,9), (10,11)

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Assumptions:
-- All intervals are either integer intervals, or they at least have only
   integer end-points
-- From the examples, it appears that intervals should be merged if, and only
   if, they share one or more elements

Algorithm:
-- All intervals in $S that share one or more elements with $N are merged with
   $N and with each other to form a single, merged interval that replaces them
   all in the output
-- All other intervals in $S remain unchanged in the output sequence

Testing:
-- Set $TEST to a true value to compare actual with expected output

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Test::More;
use lib qw( . );
use Interval;

const my $TEST  => 0;

const my @INPUT =>
(
    [ 'Example 1',    [ [1,4], [8,10]                            ], [ 2, 6] ],
    [ 'Example 2',    [ [1,2], [3, 7], [ 8,10]                   ], [ 5, 8] ],
    [ 'Example 3',    [ [1,5], [7, 9]                            ], [10,11] ],
    [ 'N precedes S', [ [1,5], [7, 9]                            ], [-1, 0] ],
    [ 'N follows S',  [ [1,4], [8,10]                            ], [12,14] ],
    [ 'Multi-merge',  [ [0,2], [4,11], [11,11], [11,13], [15,17] ], [ 9,14] ],
    [ 'N matches 1',  [ [0,1], [2, 3], [ 4, 5]                   ], [ 2, 3] ],
    [ 'Merge start',  [ [0,3], [5, 7]                            ], [-4, 2] ],
    [ 'Merge end',    [ [3,5], [7,10]                            ], [ 9,12] ],
);

const my @OUTPUT =>
(
    [ 'Example 1',    [ { start =>  1, end =>  6 },
                        { start =>  8, end => 10 } ] ],
    [ 'Example 2',    [ { start =>  1, end =>  2 },
                        { start =>  3, end => 10 } ] ],
    [ 'Example 3',    [ { start =>  1, end =>  5 },
                        { start =>  7, end =>  9 },
                        { start => 10, end => 11 } ] ], 
    [ 'N precedes S', [ { start => -1, end =>  0 },
                        { start =>  1, end =>  5 },
                        { start =>  7, end =>  9 } ] ],
    [ 'N follows S',  [ { start =>  1, end =>  4 },
                        { start =>  8, end => 10 },
                        { start => 12, end => 14 } ] ],
    [ 'Multi-merge',  [ { start =>  0, end =>  2 },
                        { start =>  4, end => 14 },
                        { start => 15, end => 17 } ] ],
    [ 'N matches 1',  [ { start =>  0, end =>  1 },
                        { start =>  2, end =>  3 },
                        { start =>  4, end =>  5 } ] ],
    [ 'Merge start',  [ { start => -4, end =>  3 },
                        { start =>  5, end =>  7 } ] ],
    [ 'Merge end',    [ { start =>  3, end =>  5 },
                        { start =>  7, end => 12 } ] ],
);

const my $USAGE =>
"\nUsage:
  perl $0
  (Add new input to the \@INPUT array)\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 092, Task #2: Insert Interval (Perl)\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    die $USAGE if scalar @ARGV > 0;

    for my $i (0 .. $#INPUT)
    {
        my   $input = $INPUT[$i];
        my   @S;
        push @S, Interval->new(start => $_->[0], end => $_->[1])
             for @{ $input->[1] };

        my $N = Interval->new(start => $input->[2][0], end => $input->[2][1]);

        unless ($TEST)
        {
            printf "\n%s\nInput:  \$S = %s; \$N = %s\n", $input->[0],
                    join(', ', map { $_->display } @S),  $N->display;
        }

        my @out = insert_interval(\@S, $N);

        if ($TEST)
        {
            is($input->[0],  $OUTPUT[$i]->[0],
                             $input->[0] . ': Same names');

            is_deeply(\@out, $OUTPUT[$i]->[1],
                             $input->[0] . ': Interval inserted correctly');
        }
        else
        {
            printf "Output: %s\n", join ', ', map { $_->display } @out;
        }
    }

    done_testing if $TEST;
}

#------------------------------------------------------------------------------
sub insert_interval
#------------------------------------------------------------------------------
{
    my ($S, $N) = @_;
    my  $merged = 0;
    my  @out;

    # Note: The logic in the loop below relies on the Task requirement that the
    #       input intervals be *sorted* (in increasing order)

    for my $interval (@$S)
    {
        if ($merged || $interval->precedes($N))
        {
            push @out, $interval;
        }
        elsif ($N->precedes($interval))
        {
            push @out, $N, $interval;
            $merged = 1;
        }
        else
        {
            $N = $N->merge($interval);
        }
    }

    push @out, $N unless $merged;

    return @out;
}

###############################################################################
