#! /usr/bin/raku

use Test;

plan 3;

is(samestring(['ab', 'c'], ['a', 'bc']), True, 'example 1');
is(samestring(['ab', 'c'], ['ac', 'b']), False, 'example 2');
is(samestring(['ab', 'cd', 'e'], ['abcde']), True, 'example 3');

sub samestring(@a, @b) {
    return @a.join('') eq @b.join('');
}
