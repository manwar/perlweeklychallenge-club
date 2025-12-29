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

sub minimumDepth(Node $root) {
    if !$root {
        return 0;
    }

    if !$root.left {
        return 1 + minimumDepth($root.right);
    }

    if !$root.right {
        return 1 + minimumDepth($root.left);
    }

    return 1 + (minimumDepth($root.left), minimumDepth($root.right)).min;
}

sub MAIN(
    *@nodes where { @nodes.elems } #= level-order tree nodes
 ) {
    say minimumDepth(makeTree(@nodes));
}