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


sub getMaxPath(Node $node, $diameter is rw) {
    if !$node {
        return 0;
    }

    my $left = getMaxPath($node.left, $diameter);
    my $right = getMaxPath($node.right, $diameter);

    if $left + $right > $diameter {
        $diameter = $left + $right;
    }

    return max($left, $right) + 1;
}

sub MAIN(
    *@nodes
) {
    my Node $root = makeTree(@nodes);
    my $diameter = 0;
    my @path = ();

    getMaxPath($root, $diameter);
    say $diameter;
}