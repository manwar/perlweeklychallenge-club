#!/usr/bin/env raku

class node {
    has UInt $.value;
    has node $.left   is rw;
    has node $.right  is rw;
    has node $.parent is rw;  
}

sub traverse($node) {
    if $node.left {
        $node.left.parent = $node;
        traverse($node.left);
    }

    if $node.right {
        $node.right.parent = $node;
        traverse($node.right);
    }

    unless $node.left or $node.right {
        sum_path($node);
    }
}

sub sum_path($node is copy) {
    my @path;

    loop {
        @path.push($node.value);
        last unless $node.parent;
        $node = $node.parent;
    }
        
    say @path.reverse.join(" -> ") ~ " == 22" if @path.sum == 22;
}

my $root = node.new(value => 5, parent => Nil);

$root.left  = node.new(value => 4);
$root.right = node.new(value => 8);

$root.left.left = node.new(value => 11);

$root.left.left.left  = node.new(value => 7);
$root.left.left.right = node.new(value => 2);

$root.right.left  = node.new(value => 13);
$root.right.right = node.new(value => 9);

$root.right.right.right = node.new(value => 1);

traverse($root);
