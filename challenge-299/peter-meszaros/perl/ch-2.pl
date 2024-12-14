#!/usr/bin/env perl
#
=head1 Task 2: Word Search

Submitted by: Mohammad Sajid Anwar

You are given a grid of characters and a string.

Write a script to determine whether the given string can be found in the given
grid of characters. You may start anywhere and take any orthogonal path, but
may not reuse a grid cell.

=head2 Example 1

    Input: @chars = (['A', 'B', 'D', 'E'],
                     ['C', 'B', 'C', 'A'],
                     ['B', 'A', 'A', 'D'],
                     ['D', 'B', 'B', 'C'])
          $str = 'BDCA'
    Output: true

=head2 Example 2

    Input: @chars = (['A', 'A', 'B', 'B'],
                     ['C', 'C', 'B', 'A'],
                     ['C', 'A', 'A', 'A'],
                     ['B', 'B', 'B', 'B'])
          $str = 'ABAC'
    Output: false

=head2 Example 3

    Input: @chars = (['B', 'A', 'B', 'A'],
                     ['C', 'C', 'C', 'C'],
                     ['A', 'B', 'A', 'B'],
                     ['B', 'B', 'A', 'A'])
          $str = 'CCCAA'
    Output: true

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[[['A', 'B', 'D', 'E'],
       ['C', 'B', 'C', 'A'],
       ['B', 'A', 'A', 'D'],
       ['D', 'B', 'B', 'C']], 'BDCA'],  1, 'Example 1'],
    [[[['A', 'A', 'B', 'B'],
       ['C', 'C', 'B', 'A'],
       ['C', 'A', 'A', 'A'],
       ['B', 'B', 'B', 'B']], 'ABAC'],  0, 'Example 2'],
    [[[['B', 'A', 'B', 'A'],
       ['C', 'C', 'C', 'C'],
       ['A', 'B', 'A', 'B'],
       ['B', 'B', 'A', 'A']], 'CCCAA'], 1, 'Example 3'],
    [[[['a', 'x', 'm', 'y'],
       ['b', 'g', 'd', 'f'],
       ['x', 'e', 'e', 't'],
       ['r', 'a', 'k', 's']], 'geeks'], 1, 'Example 4'],
];

sub find_match
{
    my ($mat, $word, $i, $j, $idx) = @_;

    my $l = length $word;
    my $n = $mat->@*;
    my $m = $mat->[0]->@*;

    return 1 if $idx == $l;

    return 0 if $i < 0 or $j < 0 or $i >= $n or $j >= $m;

    if ($mat->[$i]->[$j] eq substr($word, $idx, 1)) {

        my $temp = $mat->[$i]->[$j];
        $mat->[$i]->[$j] = '#';

        my $res = (find_match($mat, $word, $i-1, $j,   $idx+1) or
                   find_match($mat, $word, $i+1, $j,   $idx+1) or
                   find_match($mat, $word, $i,   $j-1, $idx+1) or
                   find_match($mat, $word, $i,   $j+1, $idx+1));

        $mat->[$i]->[$j] = $temp;
        return $res;
    }

    return 0;
}

sub word_search
{
    my $mat  = $_[0]->[0];
    my $word = $_[0]->[1];

    my $l = length $word;
    my $n = $mat->@*;
    my $m = $mat->[0]->@*;

    return 0 if $l > ($n * $m);

    for my $i (0 .. $n-1) {
        for my $j (0 .. $m-1) {
            if ($mat->[$i]->[$j] eq substr($word, 0, 1)) {
                return 1 if find_match($mat, $word, $i, $j, 0);
            }
        }
    }
    return 0;
}

for (@$cases) {
    is(word_search($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

