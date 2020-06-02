#!/usr/bin/env perl6

use v6.d;

sub MAIN(Str :$string = '  hello world', Regex :$regex = rx/ <[ea]>l /) {
    last-word($string, $regex).say;
}

sub last-word(Str $string, Regex $regex) {
    return ($string.split(" ").reverse.grep: { $_ ~~ $regex }).[0];
}
