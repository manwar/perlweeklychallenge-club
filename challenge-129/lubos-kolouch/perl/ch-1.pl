#!/usr/bin/perl
use strict;
use warnings;

my %tree = (1 => [2, 3], 3 => [4], 4 => [5, 6]);

sub distance {
    my ($node, $root, $dist) = @_;
    return $dist if $root == $node;
    return unless exists $tree{$root};
    foreach my $child (@{$tree{$root}}) {
        my $d = distance($node, $child, $dist + 1);
        return $d if defined $d;
    }
    return;
}

print distance(6, 1, 0), "\n";
print distance(5, 1, 0), "\n";
print distance(2, 1, 0), "\n";
print distance(4, 1, 0), "\n";

