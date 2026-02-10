#! /usr/bin/raku

use Test;

plan 5;

is(wordsorter('The quick brown fox'), 'brown fox quick The', 'example 1');
is(wordsorter('Hello    World!   How   are you?'), 'are Hello How World! you?', 'example 2');
is(wordsorter('Hello'), 'Hello', 'example 3');
is(wordsorter('Hello, World! How are you?'), 'are Hello, How World! you?', 'example 4');
is(wordsorter('I have 2 apples and 3 bananas!'), '2 3 and apples bananas! have I', 'example 5');

sub wordsorter($a) {
    my @w = $a.split(/\s+/).grep({$_ ne ""});;
    @w = @w.sort({.lc});
    @w.join(' ');
}
