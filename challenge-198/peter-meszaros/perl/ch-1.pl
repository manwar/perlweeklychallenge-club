#!/usr/bin/env perl
#
=head1 Task 1: Max Gap

Submitted by: Mohammad S Anwar

You are given a list of integers, @list.

Write a script to find the total pairs in the sorted list where 2 consecutive
elements has the max gap. If the list contains less then 2 elements then return
0.

=head2 Example 1

    Input:  @list = (2,5,8,1)
    Output: 2

    Since the sorted list (1,2,5,8) has 2 such pairs (2,5) and (5,8)

=head2 Example 2

    Input: @list = (3)
    Output: 0

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/max/;

my $cases = [
    [[2, 5, 8, 1], 2, 'Example 1'],
    [[3],          0, 'Example 2'],
];

sub max_gap
{
    my $l = shift;

    my %h;
    my @ls = sort {$a <=> $b} @$l;
    for my $i (1 .. $#ls) {
        ++$h{$ls[$i] - $ls[$i-1]};
    }
    return %h ? $h{max(keys %h)} : 0;
}

for (@$cases) {
    is(max_gap($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
