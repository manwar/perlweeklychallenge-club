#!/usr/bin/env raku

class Node {
    has $.val;
    has $.sum   is rw;
    has $.left  is rw;
    has $.right is rw;
}

my $example-one            = Node.new(:val(1)); 
   $example-one.left       = Node.new(:val(2));
   $example-one.left.left  = Node.new(:val(3));
   $example-one.left.right = Node.new(:val(4));

my $example-two             = Node.new(:val(1));
   $example-two.left        = Node.new(:val(2));
   $example-two.right       = Node.new(:val(3));
   $example-two.left.left   = Node.new(:val(4));
   $example-two.right.left  = Node.new(:val(5));
   $example-two.right.right = Node.new(:val(6));

say sum-path($example-one);
say sum-path($example-two);

sub sum-path(Node $node) {
    my $result;
    traverse($node, 0);
    return $result;

    sub traverse($node, $sum) {
        $node.sum = $node.val + $sum;

        traverse($node.left,  $node.sum) if $node.left;
        traverse($node.right, $node.sum) if $node.right;

        unless $node.left or $node.right { 
            $result += $node.sum; 
        }
    }
}
