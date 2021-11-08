#!/usr/bin/env raku

use Tree::Binary:ver<0.0.6>;

class IntTree does Tree::Binary::Role::BinaryTree[Int] {};

multi sub MAIN('test') {
    use Test;
    ok validate-bst("8(5(4)(6))(9)");
    ok !validate-bst("5(4(3)(6))(7)");
}

sub validate-bst( Str $t ) {
    my IntTree(Str) $tree = $t;
    $tree.Seq ~~ $tree.Seq.sort;
}
