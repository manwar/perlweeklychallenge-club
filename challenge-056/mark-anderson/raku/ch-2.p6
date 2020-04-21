#!/usr/bin/env raku

class node {
    has UInt  $.value;
    has Array $.parents  is rw;
    has node  $.left     is rw;
    has node  $.right    is rw;
}

sub traverse($node) {
    my @parents = [$node.value, |$node.parents];

    if $node.left {
        $node.left.parents = @parents;
        traverse($node.left);
    }

    if $node.right {
        $node.right.parents = @parents;
        traverse($node.right);
    }

    unless $node.left or $node.right {
        say @parents.reverse.join(" -> ") ~ " == 22" if @parents.sum == 22;
    }
}

my $root = node.new(value => 5, parents => []);

$root.left  = node.new(value => 4);
$root.right = node.new(value => 8);

$root.left.left = node.new(value => 11);

$root.left.left.left  = node.new(value => 7);
$root.left.left.right = node.new(value => 2);

$root.right.left  = node.new(value => 13);
$root.right.right = node.new(value => 9);

$root.right.right.right = node.new(value => 1);

traverse($root);
