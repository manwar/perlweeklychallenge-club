#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my $tree = [5, [4, [11, [7], [2]]], [8, [13], [9, [1]]]] ;

sub dfs {
    my ($node, $target, $sum, $path) = @_;
    my $new_sum = $sum + $node->[0];
    unless (exists $node->[1] or exists $node->[2]) {
        say $new_sum, " -> @$path $node->[0]" if $new_sum == $target;
    }
    dfs($node->[1], $target, $new_sum, [@$path, $node->[0]])
        if defined $node->[1];
    dfs($node->[2], $target, $new_sum, [@$path, $node->[0]])
        if defined $node->[2];
}

my $target = shift // 22;
dfs($tree, $target, 0, []);
