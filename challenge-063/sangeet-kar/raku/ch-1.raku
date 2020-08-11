#!/usr/bin/env raku

use Test;

sub last_word ($string, $regex) {
        $string.words.reverse.first($regex);   
}

is last_word('  hello world',                rx/<[ea]>l/), 'hello'; 
is last_word("Don't match too much, Chet!",  rx:i/ch.t/), 'Chet!'; 
is last_word("spaces in regexp won't match", rx:s/in re/), Nil; 
is last_word( join(' ', 1..1e6),             rx/^(3.*?) ** 3/), '399933';
done-testing;
