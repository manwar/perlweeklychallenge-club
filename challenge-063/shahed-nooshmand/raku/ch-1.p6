#!/usr/bin/env perl6

use v6.d;

sub MAIN(Str $string, Regex $regex) {
    last-word($string, $regex);
}

sub last-word(Str $string, Regex $regex) {
    .return when $regex for $string.words.reverse
}
