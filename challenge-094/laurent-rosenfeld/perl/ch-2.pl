#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;

my @tests = ( [1, [2, [3,], [4,]]],
              [1, [2, [4,]], [3, [5], [6, ]]],
              [5, [4, [3, [7], [2]]], [8, [2], [9, [1]]]]
            );
my @flat_list;
for my $tree (@tests) {
    # say Dumper @$tree;
    my @flat_tree = flatten_it($tree);
    say "Flat tree; @flat_tree";
    my $ll_root = list_to_linked_list(@flat_tree);
    # say "Linked list: ", Dumper $ll_root;
    my @flatten_ll = flatten_it($ll_root);
    say "Flat linked list: @flatten_ll \n";
}
sub flatten_it {
    my $node = shift;
    @flat_list = ();
    dfs($node);
    return @flat_list
}
sub dfs {
    my $node = shift;
    push @flat_list, $node->[0];
    dfs($node->[1]) if defined $node->[1];
    dfs($node->[2]) if defined $node->[2];
}
sub list_to_linked_list {
    my @list = @_;
    my $last = pop @list;
    my $current = [$last, ];
    for my $item (reverse @list) {
        $current = [$item, $current];
    }
    return $current;
}
