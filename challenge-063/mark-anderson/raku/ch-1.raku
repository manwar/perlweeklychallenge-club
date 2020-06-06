#!/usr/bin/env raku 

say last_word(' hello world',                 rx/<[ea]>l/);
say last_word("Don't match too much, Chet!",  rx:i/ch.t/);
say last_word("spaces in regexp won't match", rx:s/in re/);
say last_word(join(' ', 1..1e6),              rx/^(3.*?)**3/);

sub last_word(Str $string, Regex $regexp) {

    return $string.words.grep($regexp).Array.pop || Nil;

}
