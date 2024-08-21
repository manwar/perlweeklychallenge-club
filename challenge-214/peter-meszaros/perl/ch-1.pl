#!/usr/bin/env perl
#
=head1 Task 1: Rank Score

Submitted by: Mohammad S Anwar

You are given a list of scores (>=1).

Write a script to rank each score in descending order. First three will get
medals i.e. G (Gold), S (Silver) and B (Bronze). Rest will just get the ranking
number.

    Using the standard model of giving equal scores equal rank, then advancing
    that number of ranks.

=head2 Example 1

    Input: @scores = (1,2,4,3,5)
    Output: (5,4,S,B,G)

    Score 1 is the 5th rank.
    Score 2 is the 4th rank.
    Score 4 is the 2nd rank i.e. Silver (S).
    Score 3 is the 3rd rank i.e. Bronze (B).
    Score 5 is the 1st rank i.e. Gold (G).

=head2 Example 2

    Input: @scores = (8,5,6,7,4)
    Output: (G,4,B,S,5)

    Score 8 is the 1st rank i.e. Gold (G).
    Score 4 is the 4th rank.
    Score 6 is the 3rd rank i.e. Bronze (B).
    Score 7 is the 2nd rank i.e. Silver (S).
    Score 4 is the 5th rank.

=head2 Example 3

    Input: @list = (3,5,4,2)
    Output: (B,G,S,4)

=head2 Example 4

    Input: @scores = (2,5,2,1,7,5,1)
    Output: (4,S,4,6,G,S,6)

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[1, 2, 4, 3, 5],       [ 5,   4,  'S', 'B', 'G'],         'Example 1'],
    [[8, 5, 6, 7, 4],       ['G',  4,  'B', 'S',  5],          'Example 2'],
    [[3, 5, 4, 2],          ['B', 'G', 'S',  4],               'Example 3'],
    [[2, 5, 2, 1, 7, 5, 1], [ 4,  'S',  4,   6,  'G', 'S', 6], 'Example 4'],
    [[2, 5, 2, 1, 5, 5, 1], [ 4,  'G',  4,   6,  'G', 'G', 6], 'Example 5'],
];

sub rank_score
{
    my $scores = shift;
    my @medals = qw/G S B/;

    my @score_sorted = sort {$b <=> $a} @$scores;
    my %ranks;
    for my $i (0 .. $#score_sorted) {
        $ranks{$score_sorted[$i]} //= $medals[$i];
        $ranks{$score_sorted[$i]} //= ($i + 1);
    }
    return [@ranks{@$scores}];
}

for (@$cases) {
    is(rank_score($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
