#!/usr/bin/env raku

multi paths(Pair $tree) {
    |paths($tree.value).map: {$tree.key, |$_}
}
multi paths(Positional $nodes) {
    $nodes.map: { paths $_ }
}
multi paths($leaf) { $leaf }

my $tree = 5 => (4 => 11 => (7, 2),
                 8 => (9 => 1, 13));
say %(paths($tree).map: {.sum => $_}){22}
