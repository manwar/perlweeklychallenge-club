#!/usr/bin/raku


class Node {
    has $.val;
    has Node $.left is rw;
    has Node $.right is rw;
}

sub makeTree(@values) {
    my Node @tree;

    for @values.keys -> $i {
        if @values[$i] eq q{-} {
            next;
        }
        @tree[$i] = Node.new(val => @values[$i]);
    }

    for @tree.keys -> $i {
        if (!@tree[$i]) {
            next;
        }

        my $l = 2 * $i + 1;
        my $r = 2 * $i + 2;

        if $l <= @tree.elems - 1 && @tree[$l] {
            @tree[$i].left = @tree[$l];
        }

        if $r <= @tree.elems - 1 && @tree[$r] {
            @tree[$i].right = @tree[$r];
        }
    }

    return @tree[0];
}

sub getMaxPath(Node $root) {
    my $diameter = 0;

    sub dfs($node) {
        if !$node {
            return 0;
        }

        my $leftHeight = dfs($node.left);
        my $rightHeight = dfs($node.right);

        $diameter = max($diameter, $leftHeight + $rightHeight);

        return 1 + max($leftHeight, $rightHeight);
    }

    dfs($root);
    return $diameter;
}

sub MAIN(
    *@nodes
) {
    say getMaxPath(makeTree(@nodes));
}