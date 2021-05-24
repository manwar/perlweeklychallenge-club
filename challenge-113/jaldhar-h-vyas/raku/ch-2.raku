#!/usr/bin/raku

class Node {
    has Node $.parent;
    has Node $.left is rw;
    has Node $.right is rw;
    has Int  $.value  is rw;
}

sub totalFrom(
    Node $node
) {
    my $sum = $node.value;

    if $node.left {
        $sum += totalFrom($node.left);
    }

    if $node.right {
        $sum += totalFrom($node.right);
    }

    return $sum;
}

sub replaceFrom(
    Node $node,
    Int $total
) {
    $node.value = $total - $node.value;

    if $node.left {
        replaceFrom($node.left, $total);
    }

    if $node.right {
        replaceFrom($node.right, $total);
    }
}

sub output(
    Node $node,
    Bool $left = False
) {
    if $node.parent {
        say (($left) ?? 'left' !! 'right'), " child of {$node.parent.value} = {$node.value}";
    } else {
        say "root = {$node.value}"
    }

    if $node.left {
        output($node.left, True);
    }

    if $node.right {
        output($node.right);
    }
}

sub MAIN() {
    my Node $root = Node.new(parent => Nil, value => 1);
    $root.left = Node.new(parent => $root, value => 2);
    $root.right = Node.new(parent => $root, value => 3);
    $root.left.left = Node.new(parent => $root.left, value => 4);
    $root.right.left = Node.new(parent => $root.right, value => 5);
    $root.right.right = Node.new(parent => $root.right, value => 6);
    $root.left.left.right = Node.new(parent => $root.left.left, value => 7);

    my $total = totalFrom($root);
 
    replaceFrom($root, $total);

    output($root);
}