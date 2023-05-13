#!/usr/bin/perl6

class Node {
    has Node $.left;
    has Node $.right;
    has Int  $.amount;
}

sub traverse(Node $node, @path is copy, $target) {
    @path.push($node.amount);

    unless $node.left || $node.right {
        if @path.sum == $target {
            say @path.join(' -> ');
        }
        return;
    }

    if $node.left {
        traverse($node.left, @path, $target);
    }

    if $node.right {
        traverse($node.right, @path, $target);
    }
}

sub MAIN {
    my Node $node = Node.new(
        left => Node.new(
            left => Node.new(
                left => Node.new(
                    left => Nil,
                    right => Nil,
                    amount => 7
                ),
                right => Node.new(
                    left => Nil,
                    right => Nil,
                    amount => 2
                ),
                amount => 11
            ),
            right => Nil,
            amount => 4
        ),
        right => Node.new(
            left => Node.new(
                left => Nil,
                right => Nil,
                amount => 13
            ),
            right => Node.new(
                left => Nil,
                right => Node.new(
                    left => Nil,
                    right => Nil,
                    amount => 1
                ),
                amount => 9
            ),
            amount => 8
        ),
        amount => 5
    );

    traverse($node, [], 22);
}