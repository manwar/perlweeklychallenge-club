#!/usr/bin/env perl
# Perl weekly challenge 113
# Task 2: Recreate binary tree.
#
# See https://wlmb.github.io/2021/05/22/PWC113/#task-2-recreate-binary-tree
use strict;
use warnings;
use v5.12;
use List::Util qw(sum0);

while(my $tree_string=shift @ARGV){
    say "Input:  $tree_string";
    die "Suspicious tree $tree_string"
         unless $tree_string=~m{^[][,\-+\d\.\se]*$};
    my $tree=eval $tree_string;
    die "Bad expression: @!" if @!;
    say "Output: ",
        stringify_tree(subtract_tree($tree, sum_tree($tree)));
}

sub sum_tree { #sum and do some rough validation
    my $node=shift;
    die "Wrong format" unless ref($node) eq "ARRAY";
    return 0 if @$node==0;
    return $node->[0]
           +sum0 map {sum_tree($node->[$_])} (1,2) if @$node==3;
    die "Wrong format";
}

sub subtract_tree {
    my ($node, $from)=@_;
    return [] if @$node==0;
    return [$from-$node->[0],
            map {subtract_tree($node->[$_], $from)} (1,2)];
}

sub stringify_tree {
    my $node=shift;
    return "[]" if @$node==0;
    return sprintf("[%s,%s,%s]", $node->[0],
           map {stringify_tree($node->[$_])} (1,2));
}
