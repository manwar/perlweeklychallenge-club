#!/usr/bin/env perl6

use Test;

is last-word('  hello world',                rx  / <[ea]>l   /), 'hello';
is last-word("Don't match too much, Chet!",  rx:i/ ch.t      /), 'Chet!';
is last-word("spaces in regexp won't match", rx:s/ in re     /), Nil;
is last-word( (1..1e6).join(' '),            rx  /^^(3.*?)**3/), '399933';

done-testing;

sub last-word(Str $string, Regex $regex) {
    return $string.split(" ").reverse.grep($regex).head;
}
