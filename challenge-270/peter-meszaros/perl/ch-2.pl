#!/usr/bin/env perl
#
=head1 Task 2: Distribute Elements

You are give an array of integers, @ints and two integers, $x and $y.

Write a script to execute one of the two options:

    Level 1:
    Pick an index i of the given array and do $ints[i] += 1

    Level 2:
    Pick two different indices i,j and do $ints[i] +=1 and $ints[j] += 1.

You are allowed to perform as many levels as you want to make every elements in
the given array equal. There is cost attach for each level, for Level 1, the
cost is $x and $y for Level 2.

In the end return the minimum cost to get the work done.

=head2 Example 1

    Input: @ints = (4, 1), $x = 3 and $y = 2
    Output: 9

    Level 1: i=1, so $ints[1] += 1.
    @ints = (4, 2)

    Level 1: i=1, so $ints[1] += 1.
    @ints = (4, 3)

    Level 1: i=1, so $ints[1] += 1.
    @ints = (4, 4)

We perforned operation Level 1, 3 times.
So the total cost would be 3 x $x => 3 x 3 => 9

=head2 Example 2

    Input: @ints = (2, 3, 3, 3, 5), $x = 2 and $y = 1
    Output: 6

    Level 2: i=0, j=1, so $ints[0] += 1 and $ints[1] += 1
    @ints = (3, 4, 3, 3, 5)

    Level 2: i=0, j=2, so $ints[0] += 1 and $ints[2] += 1
    @ints = (4, 4, 4, 3, 5)

    Level 2: i=0, j=3, so $ints[0] += 1 and $ints[3] += 1
    @ints = (5, 4, 4, 4, 5)

    Level 2: i=1, j=2, so $ints[1] += 1 and $ints[2] += 1
    @ints = (5, 5, 5, 4, 5)

    Level 1: i=3, so $ints[3] += 1
    @ints = (5, 5, 5, 5, 5)

We perforned operation Level 1, 1 time and Level 2, 4 times.
So the total cost would be (1 x $x) + (3 x $y) => (1 x 2) + (4 x 1) => 6

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/max/;

my $cases = [
    [[[4, 1],          3, 2], 9],
    [[[2, 3, 3, 3, 5], 2, 1], 6],
    [[[3, 3, 4, 4],    1, 1], 1],
    [[[3, 3, 4, 4],    1, 2], 2],
    [[[3, 3, 4, 4],    1, 3], 2],
];

# get max diff
# for pair of maxes   -> decrement 
#                        if level2 cheaper than two level1 --> count level2 step
#                        else                              --> count two level1 step
#                        undef maxes
# if exist single max -> decrement
#                        count level1 step
#                        undef maxes
# repeat until max diff == 0
sub distribute_elements
{
    my $l = $_[0]->[0];
    my $x = $_[0]->[1];
    my $y = $_[0]->[2];

    my $x_cnt = 0;
    my $y_cnt = 0;

    my $max = max @$l;
    my @diff = map { $max - $_ } @$l;

    my @max;
    while (my $max = max @diff) {
        for my $i (0..$#diff) {
            if ($diff[$i] == $max) {
                push @max, $i;
                if (@max == 2) {
                    --$diff[$max[0]];
                    --$diff[$max[1]];
                    if ((2 * $x) < $y) { 
                        $x_cnt += 2;
                    } else {
                        ++$y_cnt;
                    }
                    undef @max;
                }
            }
        }
        if (@max) {
            --$diff[$max[0]];
            ++$x_cnt;
            undef @max;
        }
    }
    
    return $x_cnt * $x + $y_cnt * $y;
}

for (@$cases) {
    is(distribute_elements($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

