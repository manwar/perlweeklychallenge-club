
class IntBinaryTree {
    has Int $.payload;
    has $.left-child;
    has $.right-child;
}

sub MAIN {
    example1;
    example2;
}

sub example1 {
    my $b = IntBinaryTree.new(
        :payload(1),
        :left-child(
            IntBinaryTree.new(
                :payload(2),
                :left-child(IntBinaryTree.new(:payload(3))),
                :right-child(IntBinaryTree.new(:payload(4)))
            )
        )
    );

    say "Example 1: " ~ sum-of-paths($b);
}

sub example2 {
    my $b = IntBinaryTree.new(
        :payload(1),
        :left-child(
            IntBinaryTree.new(
                :payload(2),
                :left-child(IntBinaryTree.new(:payload(4))),
            )
        ),
        :right-child(
            IntBinaryTree.new(
                :payload(3),
                :left-child(IntBinaryTree.new(:payload(5))),
                :right-child(IntBinaryTree.new(:payload(6)))
            )
        )
    );

    say "Example 2: " ~ sum-of-paths($b);
}

sub sum-of-paths ($tree) {
    my ($sum, $paths) = sum-and-paths($tree);
    return $sum;
}

sub sum-and-paths ($tree) {
    unless $tree.left-child or $tree.right-child {
        return ($tree.payload, 1);
    }

    my $paths = 0;
    my $sum = 0;   
    if $tree.left-child {
        my ($left-sum, $left-paths) = sum-and-paths($tree.left-child);
        $sum += $left-paths * $tree.payload + $left-sum;
        $paths += $left-paths;
    }
    if $tree.right-child {
        my ($right-sum, $right-paths) = sum-and-paths($tree.right-child);
        $sum += $right-paths * $tree.payload + $right-sum;
        $paths += $right-paths;
    }
    return ($sum, $paths);
}

