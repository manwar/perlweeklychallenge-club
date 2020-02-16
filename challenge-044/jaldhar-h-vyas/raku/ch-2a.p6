#!/usr/bin/perl6

class Node {
    has Node $.parent;
    has Node $.left   is rw;
    has Node $.right  is rw;
    has Str  $.label;
    has Int  $.amount;
}

sub traverse(Node $node,  @bestBranch,  $maxDepth is rw, $depth) {
    if $depth < $maxDepth && $node.amount < 200 {
        $node.left = Node.new(parent => $node, amount => $node.amount * 2,
            label => 'double');
        $node.right = Node.new(parent => $node, amount => $node.amount + 1,
            label => 'add one');
        traverse($node.left(), @bestBranch, $maxDepth, $depth + 1);
        traverse($node.right(), @bestBranch, $maxDepth, $depth + 1);

    } elsif $node.amount == 200 && $depth < $maxDepth {
        $maxDepth = $depth;
        my @branch;
        my $current = $node;

        while ($current.parent()) {
            @branch.unshift($current.label());
            $current = $current.parent();
        }
        @bestBranch = @branch;
    }
}

multi sub MAIN {
    my @results;
    my $root = Node.new(parent => Nil, label => q{}, amount => 1);
    my $maxDepth = ∞;
    traverse($root, @results, $maxDepth, 0);

    @results.join(', ').say;
}