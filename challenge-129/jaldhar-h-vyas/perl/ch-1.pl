#!/usr/bin/perl
use 5.40.1;
use warnings;
use feature qw/ class /;
no warnings qw/ experimental::class /;

class Node {
    field $val :param :reader;
    field $left :reader;
    field $right :reader;

    method setLeft($l) {
        $left = $l;
    }

    method setRight($r) {
        $right = $r;
    }
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

sub distanceToNode($root, $val) {
    if (!$root) {
        return undef;
    }

    if ($root->val == $val) {
        return 0;
    }

    if (defined $root->left) {
        my $leftDistance = distanceToNode($root->left, $val);
        if (defined $leftDistance) {
            return $leftDistance + 1;
        }
    }

    if (defined $root->right) {
        my $rightDistance = distanceToNode($root->right, $val);
        if (defined $rightDistance) {
            return $rightDistance + 1;
        }
    }

    return undef;
}


my ($node, $tree) = @ARGV;

say distanceToNode(makeTree(split /\s+/, $tree), $node);