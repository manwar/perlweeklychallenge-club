#! /usr/bin/raku

multi array-of-product(@n where *.elems == 1) {
    (0,)
}

multi array-of-product(@n) {
    @n.combinations(@n.elems.pred).reverse.map: { [*] $_ }
}

if @*ARGS > 0 {
    say array-of-product(@*ARGS>>.Int).join(', ');
    exit 0;
}

use Test;

is-deeply array-of-product((999,)), (0,), 'One element returns 0';
is-deeply array-of-product((999, 888)), (888, 999), 'Two elements invert positions';
is-deeply array-of-product((5, 2, 1, 4, 3)), (24, 60, 120, 30, 40), 'Example 1';
is-deeply array-of-product((2, 1, 4, 3)), (12, 24, 6, 8), 'Example 2';

done-testing;
