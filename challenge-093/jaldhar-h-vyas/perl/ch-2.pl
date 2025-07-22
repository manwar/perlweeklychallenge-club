#!/usr/bin/perl
use 5.038;
use warnings;
use English;
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

sub sumPaths($node, $num, $sum) {
    if (!$node) {
        return $sum;
    }

    $num += $node->val;

    if (!$node->left && !$node->right) {
        $sum += $num;
    } else {
        $sum = sumPaths($node->left, $num, $sum);
        $sum = sumPaths($node->right, $num, $sum);
    }

    return $sum;
}

my @nodes = @ARGV;

if (scalar @nodes < 1) {
    die "Usage: $PROGRAM_NAME <level-order tree nodes>\n";
}

say sumPaths(makeTree(@nodes), 0, 0);
