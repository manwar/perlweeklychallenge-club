#!/usr/bin/env perl
# Perl weekly challenge 130
# Task 2:  Binary search tree
#
# See https://wlmb.github.io/2021/09/15/PWC130/#task-2-binary-search-tree
use warnings;
use v5.12;
use YAML::Tiny;
$/=''; #slurp
my $tree=YAML::Tiny->read_string(my $data=<>);
my ($result)=is_bst($tree->[0]);
say "Input:\n$data\nOutput: ", $result->[0];
sub is_bst { # returns [0] on failure, [1, smallest, largest] on success
    my $tree=shift;
    return [1, undef, undef] unless defined $tree; # I consider empty trees as bst
    my $value=$tree->{v};
    die "Malformed tree" unless defined $value;
    my ($left, $right)=map {is_bst($tree->{$_})} qw(l r);
    return [0] unless $left->[0] && $right->[0]; # any children not bst=> not bst
    # set default values to $value
    my ($left_smallest, $left_largest, $right_smallest, $right_largest)
    = map {$_//$value} ($left->[1], $left->[2], $right->[1], $right->[2]);
    return [0] if $left_largest > $value || $right_smallest < $value;
    return [1, $left_smallest, $right_largest];
}
