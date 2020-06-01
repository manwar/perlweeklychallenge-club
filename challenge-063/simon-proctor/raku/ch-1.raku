#!/usr/bin/env raku

use v6.d;

sub last_word( Str $sentence, Regex $test ) {
    $sentence.words.reverse.first( $test );
}

# Test Last_word
say last_word('  hello world',                rx/<[ea]>l/);       # 'hello'
say last_word("Don't match too much, Chet!",  rx:i/ch.t/);      # 'Chet!'
say last_word("spaces in regexp won't match", rx/"in re"/);   #  undef
say last_word( join(' ', 1..1e6),             rx/^(3.*?) ** 3/);  # '399933'
