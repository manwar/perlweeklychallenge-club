#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my @tests = ( [1, [2, [3,], [4,]]],
              [1, [2, [4,]], [3, [5], [6, ]]],
              [5, [4, [3, [7], [2]]], [8, [2], [9, [1]]]]
            );
my $total_sum;
for my $tree (@tests) {
    $total_sum = 0;
    dfs($tree, 0);
    say $total_sum;
}

sub dfs {
    my ($node, $sum_so_far) = @_;
    my $new_sum = $sum_so_far + $node->[0];
    unless (exists $node->[1] or exists $node->[2]) {
        $total_sum += $new_sum;
        return;
    }
    dfs($node->[1], $new_sum)
        if defined $node->[1];
    dfs($node->[2], $new_sum)
        if defined $node->[2];
}
