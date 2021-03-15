#!/usr/bin/env raku

use v6;

#| Given a string (please quote) reverse the order of words
sub MAIN( Str $s ) {
    say $s.words.reverse.join(" ");
}
