#!/bin/env raku

sub traverse(Any:D $node, UInt:D $sum --> UInt:D) {
    $node.^name ~~ 'Int' ??
        $node + $sum     !!
    	[+] (traverse($_, $sum + $node.key) for |$node.value);
}

multi MAIN('test') {
    use Test;

    is traverse(1, 0), 1, '1 : 1';
    is traverse(1 => 2, 0), 3, '1 => 2 : 3';
    is traverse(1 => (2, 3), 0), 7, '1 => (2, 3) : 7';
}

my Array $T .= new(
    1 => (2 => (3, 4)),
	1 => (2 => 4, 3 => (5, 6)),
);

multi MAIN(UInt:D \n) {
    put traverse($T[n], 0);
}
