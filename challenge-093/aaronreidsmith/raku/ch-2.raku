#!/usr/bin/env raku

subset NodeValue of Str where { $_ ~~ /^<digit>$/ || $_ eq 'Nil' }

class Node {
    has Node $.left  is rw = Nil;
    has Node $.right is rw = Nil;
    has Int $.value        = 0;
}

sub build-tree(@array, $root is copy = Nil, Int $i = 0) {
    if $i < @array.elems && @array[$i] ne 'Nil' {
        $root       = Node.new(value => @array[$i].Int);
        $root.left  = build-tree(@array, $root.left, 2 * $i + 1);
        $root.right = build-tree(@array, $root.right, 2 * $i + 2);
    }
    $root;
}

sub challenge(Node $root, @path is copy = ()) {
    my $path-sum = 0;
    with $root {
        @path.push($root.value);

        if !$root.left.defined && !$root.right.defined {
            $path-sum = @path.sum;
        } else {
            $path-sum += challenge($root.left, @path);
            $path-sum += challenge($root.right, @path);
        }
    }
    $path-sum;
}

multi sub MAIN(*@N where all(@N) ~~ NodeValue) {
    my $root = build-tree(@N);
    say challenge($root);
}

multi sub MAIN(Bool :$test) {
    use Test;

    my @tests = (
        (build-tree(('1', '2', 'Nil', '3', '4')), 13),
        (build-tree(('1', '2', '3', '4', 'Nil', '5', '6')), 26),
        (build-tree(('2', '7', '5', '2', '6', 'Nil', '9', 'Nil', '5', '11', '4', 'Nil')), 77)
    );

    for @tests -> ($tree, $expected) {
        is(challenge($tree), $expected);
    }

    done-testing;
}
