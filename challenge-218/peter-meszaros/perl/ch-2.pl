#!/usr/bin/env perl
#
=head1 Task 2: Matrix Score

Submitted by: Mohammad S Anwar

You are given a m x n binary matrix i.e. having only 1 and 0.

You are allowed to make as many moves as you want to get the highest score.

    A move can be either toggling each value in a row or column.

To get the score, convert the each row binary to dec and return the sum.

=head2 Example 1:

    Input: @matrix = [ [0,0,1,1],
                       [1,0,1,0],
                       [1,1,0,0], ]
    Output: 39

    Move #1: convert row #1 => 1100
             [ [1,1,0,0],
               [1,0,1,0],
               [1,1,0,0], ]

    Move #2: convert col #3 => 101
             [ [1,1,1,0],
               [1,0,0,0],
               [1,1,1,0], ]

    Move #3: convert col #4 => 111
             [ [1,1,1,1],
               [1,0,0,1],
               [1,1,1,1], ]

    Score: 0b1111 + 0b1001 + 0b1111 => 15 + 9 + 15 => 39

=head2 Example 2:

    Input: @matrix = [ [0] ]
    Output: 1

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[[0,0,1,1],
      [1,0,1,0],
      [1,1,0,0]], 39, 'Example 1'],
    [[[0]],        1, 'Example 2'],
];

sub matrix_score
{
    my $m = shift;

    for my $r (@$m) {
        $r = [map { 1 - $_ } $r->@*] if $r->[0] == 0;
    }
    for my $c (0 .. $#{$m->[0]}) {
        my $ones = 0;
        for my $r (@$m) {
            $ones += $r->[$c];
        }
        if ($ones < (@$m / 2)) {
            for my $r (@$m) {
                $r->[$c] = 1 - $r->[$c];
            }
        }
    }
    
    my $sum = 0;
    for my $r (@$m) {
        $sum += unpack("N", pack("B32", substr("0" x 32 . join('', $r->@*) , -32)));
    }
    return $sum;
}

for (@$cases) {
    is(matrix_score($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
