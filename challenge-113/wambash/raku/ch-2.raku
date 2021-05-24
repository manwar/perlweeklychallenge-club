#!/usr/bin/env raku

sub recreate-binary-tree ($tree) {
    my $tree-sum = sum gather $tree.duckmap: -> Numeric:D $n { $n.take } ;
    $tree.duckmap: -> Numeric:D $n { $tree-sum - $n }
}


multi MAIN ( :test($)! ) {
    use Test;

    my $tree          = ( 1,( 2,( 4,Nil, 7),( 3, 5, 6)));
    my $recreate-tree = (27,(26,(24,Nil,21),(25,23,22)));

    is-deeply recreate-binary-tree($tree), $recreate-tree;
    done-testing;
}
