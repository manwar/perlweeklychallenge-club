#!/usr/bin/env raku

subset NodeValue of Str where { $_ ~~ /^<digit>$/ || $_ eq 'Nil' }

class Node {
    has Node $.left  is rw = Nil;
    has Node $.right is rw = Nil;
    has Int $.value        = 0;
}

enum Traversal <Preorder Inorder Postorder>;

sub build-tree(@array, $root is copy = Nil, Int $i = 0) {
    if $i < @array.elems && @array[$i] ne 'Nil' {
        $root       = Node.new(value => @array[$i].Int);
        $root.left  = build-tree(@array, $root.left, 2 * $i + 1);
        $root.right = build-tree(@array, $root.right, 2 * $i + 2);
    }
    $root;
}

sub challenge(Node $root, Traversal $traversal) {
    with $root {
        given $traversal {
            when Preorder  { ($root.value, |challenge($root.left, $traversal), |challenge($root.right, $traversal)) }
            when Inorder   { (|challenge($root.left, $traversal), $root.value, |challenge($root.right, $traversal)) }
            when Postorder { (|challenge($root.left, $traversal), |challenge($root.right, $traversal), $root.value) }
        }
    }
}

sub challenge-wrapper(Node $root, Traversal $traversal = Preorder) {
    challenge($root, $traversal).join(' -> ');
}

multi sub MAIN(Str :$traversal = 'preorder', *@N where all(@N) ~~ NodeValue) {
    my $root = build-tree(@N);
    given $traversal.lc {
        when 'preorder'  { say challenge-wrapper($root, Preorder) }
        when 'inorder'   { say challenge-wrapper($root, Inorder) }
        when 'postorder' { say challenge-wrapper($root, Postorder) }
        default          { die "Traversal must be one of: (preorder, inorder, postorder), not $traversal" }
    }
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        (('1', '2', '3', '4', '5', 'Nil', 'Nil', 'Nil', 'Nil', '6', '7'), Preorder, '1 -> 2 -> 4 -> 5 -> 6 -> 7 -> 3'),
        (('1', '2', '3', '4', '5', 'Nil', 'Nil', 'Nil', 'Nil', '6', '7'), Inorder, '4 -> 2 -> 6 -> 5 -> 7 -> 1 -> 3'),
        (('1', '2', '3', '4', '5', 'Nil', 'Nil', 'Nil', 'Nil', '6', '7'), Postorder, '4 -> 6 -> 7 -> 5 -> 2 -> 3 -> 1')
    );

    for @tests -> (@input, $traversal, $expected) {
        is(challenge-wrapper(build-tree(@input), $traversal), $expected);
    }
}
