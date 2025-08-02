#!/usr/bin/env perl
#
=head1 Task 2: Knight's Move
Submitted by: Peter Campbell Smith
A Knight in chess can move from its current position to any square two rows or
columns plus one column or row away. So in the diagram below, if it starts a S,
it can move to any of the squares marked E.
Write a script which takes a starting position and an ending position and
calculates the least number of moves required.
      +--+--+--+--+--+--+--+--+
    8 |a8|  |  |  |  |  |  |  |
    7 |  |  |E |  |E |  |  |  |
    6 |  |E |  |  |  |E |  |  |
    5 |  |  |  |S |  |  |  |  |
    4 |  |E |  |  |  |E |  |  |
    3 |  |  |E |  |E |  |  |  |
    2 |  |  |  |  |  |  |g2|  |
    1 |  |  |  |  |  |  |  |  |
      +--+--+--+--+--+--+--+--+
        a  b  c  d  e  f  g  h
=head2 Example 1
    Input: $start = 'g2', $end = 'a8'
    Ouput: 4
    g2 -> e3 -> d5 -> c7 -> a8
=head2 Example 2
    Input: $start = 'g2', $end = 'h2'
    Ouput: 3
    g2 -> e3 -> f1 -> h2
=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [['g2', 'a8'], 4, 'Example 1'],
    [['g2', 'h2'], 3, 'Example 2'],
];

sub knights_move
{
    my $s = $_[0]->[0];
    my $e = $_[0]->[1];

    my @s = split '', $s;
    my @e = split '', $e;

    $s[0] = ord($s[0]) - ord('a');
    $e[0] = ord($e[0]) - ord('a');
    $s[1]--;
    $e[1]--;

    my $dx = [2,  2, -2, -2, 1,  1, -1, -1];
    my $dy = [1, -1,  1, -1, 2, -2,  2, -2];

    my @queue = [$s[0], $s[1], 0];
    my $visited->[$s[0]]->[$s[1]] = 1;

    while (@queue) {
        my $p = shift @queue;
        my $x = $p->[0];
        my $y = $p->[1];
        my $v = $p->[2];
        if ($x == $e[0] && $y == $e[1]) {
            return $v;
        }
        for my $i (0 .. 7) {
            my $new_x = $p->[0] + $dx->[$i];
            my $new_y = $p->[1] + $dy->[$i];
            my $val   = $v + 1;
            if ($new_x >= 0 && $new_x <= 7 &&
                $new_y >= 0 && $new_y <= 7 &&
                not $visited->[$new_x]->[$new_y]) {
                $visited->[$new_x]->[$new_y] = 1;
                push @queue, [$new_x, $new_y, $val];
        	}
        }
    }
    return undef;
}

for (@$cases) {
    is(knights_move($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
