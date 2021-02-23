#!/bin/env raku

sub USAGE {
    put "$*PROGRAM 0\n" ~
        "$*PROGRAM 1\n";
}

sub tree-to-list(Any:D $node, Array:D $a --> List:D) {
    given $node {
        when Int|Str { $a.push($node) }
        when Pair    { tree-to-list($node.key, $a); tree-to-list($node.value, $a) }
        when List    { tree-to-list($_, $a) for |$node }
        when Hash    { tree-to-list($node.keys.first, $a); tree-to-list($node.values.first, $a) }
        default      { die "got { $_.^name }!" }
    }
    (|$a);
}

multi MAIN('test') {
	use Test;

    is-deeply |tree-to-list(1, my Array $a .= new), 1,   "1 : 1";
    is-deeply |tree-to-list('x', $a .= new),        'x', "x : x";

    is tree-to-list((1 => 2), $a .= new), (1, 2),   "1 => 2 : 1";
}

my @T = [
    { 1 => (2 => (4, 5 => (6, 7)), 3) },
    { 1 => (2 => (4, 5)) },
];

multi MAIN(UInt:D \n) {
	put tree-to-list(@T[n], my Array $a .= new);
}
