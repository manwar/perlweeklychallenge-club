#!/usr/bin/perl
use strict;
use warnings;

sub is_bst {
    my ($tree, $min, $max) = @_;
    return 1 unless defined $tree;
    return 0 if $tree < $min || $tree > $max;
    return is_bst($tree->{left}, $min, $tree - 1) && is_bst($tree->{right}, $tree + 1, $max);
}

my $tree = { value => 8, left => { value => 5, left => { value => 4 }, right => { value => 6 } }, right => { value => 9 } };
print is_bst($tree, -1, 100000) ? "1\n" : "0\n";

