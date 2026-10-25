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

sub isBST($root, $minimum, $maximum) {
    unless (defined $root) {
        return true;
    }

    my $value = $root->val;

    if (defined $minimum && $value < $minimum) {
        return false;
    }

    if (defined $maximum && $value > $maximum) {
        return false;
    }

    return isBST($root->left, $minimum, $value)
        && isBST($root->right, $value, $maximum);
}

my ($tree) = @ARGV;

say isBST(makeTree(split /\s+/, $tree), undef, undef) ? 1 : 0;
