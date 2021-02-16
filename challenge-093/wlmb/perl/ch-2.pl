#!/usr/bin/env perl
# Perl weekly challenge 093
# Task 2: Sum path.
# Sum all possible paths from the root to the leafs.
# See https://wlmb.github.io/2020/12/28/PWC93/#task-2-sum-path
use warnings;
use strict;
use v5.10;
use Data::Dumper;

usage() unless @ARGV; # check there are arguments
foreach(@ARGV){
    usage() unless /^[\]\[,\s0-9]*$/; # check argument
    my $tree=eval $_; # and assume the risks.
    die "Couldn't evaluate $_: $@" if $@;
    my ($sum_paths, $number_of_paths)=sum_path($tree);
    say "Input: $_\nSum_path: $sum_paths\nNumber of paths: $number_of_paths\n";
}

sub sum_path {
    my $tree=shift;
    die Dumper($tree),  " is not an array" unless ref $tree eq "ARRAY";
    my @tree=@$tree;
    my $node=shift @tree;
    die Dumper($tree), " doesn't start with a number" if ref $node;
    my $sum_of_paths=0;
    my $number_of_paths=@tree?0:1; # 1 for leaves
    foreach(@tree){
	my ($sum_of_subpaths, $number_of_subpaths)=sum_path($_);
	$sum_of_paths+=$sum_of_subpaths;
	$number_of_paths+=$number_of_subpaths;
    }
    $sum_of_paths+=$node*$number_of_paths;
    return($sum_of_paths, $number_of_paths);
}

sub usage {
      say <<'END_USAGE';
      Usage: ./ch-2.pl "tree_0" "tree_1"...
      where tree_n is a tree represented by a perl array of the form
      [node_n, [subtree_0, subtree_1...]]
      and the nodes are digits.
      Find the sum of nodes along all paths through the given trees.
END_USAGE
    exit 1;
}
