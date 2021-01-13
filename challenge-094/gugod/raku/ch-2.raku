class IntBinaryTree {
    has Int $.payload;
    has IntBinaryTree $.left-child;
    has IntBinaryTree $.right-child;
}

class IntLinkedList {
    has Int $.payload;
    has IntLinkedList $.next;

    method set-next (IntLinkedList $n) {
        $!next = $n;
    }
}

sub MAIN {
    my $tree = IntBinaryTree.new(
        :payload(1),
        :left-child(
            IntBinaryTree.new(
                :payload(2),
                :left-child(IntBinaryTree.new(:payload(4))),
                :right-child(
                    IntBinaryTree.new(
                        :payload(5),
                        :left-child(IntBinaryTree.new(:payload(6))),
                        :right-child(IntBinaryTree.new(:payload(7))),
                    )
                )
            )
        ),
        :right-child(
            IntBinaryTree.new(:payload(3))
        )
    );

    my $x = binary-tree-to-linked-list($tree);
    say preview($x);
}

sub binary-tree-to-linked-list (IntBinaryTree $tree) {
    my $head = IntLinkedList.new(:payload( $tree.payload ));
    my $tail = $head;

    if $tree.left-child {
        my $sub-list = binary-tree-to-linked-list($tree.left-child);
        $tail.set-next: $sub-list;

        while $tail.next.defined {
            $tail = $tail.next;
        }
    }

    if $tree.right-child {
        my $sub-list = binary-tree-to-linked-list($tree.right-child);
        $tail.set-next: $sub-list;

        while $tail.next.defined {
            $tail = $tail.next;
        }
    }

    return $head;
}

sub preview (IntLinkedList $s) {
    my $it = $s;

    my $out = $it.payload;
    $it = $it.next;
    while $it.defined {
        $out ~= "->" ~ $it.payload;
        $it = $it.next;
    }
    return $out;
}

