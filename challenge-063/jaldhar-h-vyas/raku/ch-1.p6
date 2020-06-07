#!/usr/bin/perl6

sub last_word(Str $string, Regex $regexp) {
    return $string.split(/\s+/).reverse.first($regexp) // Nil;
}


say last_word('  hello world',                rx/<[ea]>l/) // 'undef';      # 'hello'
say last_word("Don't match too much, Chet!",  rx:i/ch.t/) // 'undef';       # 'Chet!'
say last_word("spaces in regexp won't match", rx/in' 're/) // 'undef';      #  undef
say last_word((1 .. 1e6).join(' '),           rx/^(3.*?) ** 3/) // 'undef'; # '399933'