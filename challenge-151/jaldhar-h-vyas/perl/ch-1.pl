#!/usr/bin/perl
use 5.038;
use warnings;
use feature qw/ class /;
no warnings qw/ experimental::class /;

class Node {
    field $val :param;
    field $left;
    field $right;

    method val { return $val; }
    method left { return $left; }
    method right { return $right; }

    method setLeft($node) { $left = $node; }
    method setRight($node) { $right = $node; }
}

sub makeTree(@values) {
    my Node @tree;

    for my $i (keys @values) {
        if ($values[$i] eq q{-}) {
            next;
        }
        $tree[$i] = Node->new(val => $values[$i]);
    }

    for my $i (keys @tree) {
        if (!$tree[$i]) {
            next;
        }

        my $l = 2 * $i + 1;
        my $r = 2 * $i + 2;

        if ($l <= scalar @tree - 1 && $tree[$l]) {
            $tree[$i]->setLeft($tree[$l]);
        }

        if ($r <= scalar @tree - 1 && $tree[$r]) {
            $tree[$i]->setRight($tree[$r]);
        }
    }

    return $tree[0];
}

sub min(@arr) {
    my $lowest = 'inf';
    for my $i (@arr) {
        if ($i < $lowest) {
            $lowest = $i;
        }
    }

    return $lowest;
}

sub minimumDepth($root) {
    if (!$root) {
        return 0;
    }

    if (!$root->left) {
        return 1 + minimumDepth($root->right);
    }

    if (!$root->right) {
        return 1 + minimumDepth($root->left);
    }

    return 1 + min(minimumDepth($root->left), minimumDepth($root->right));
}

my @nodes = @ARGV;

say minimumDepth(makeTree(@nodes));
