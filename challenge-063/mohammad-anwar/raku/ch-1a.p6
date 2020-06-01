#!/usr/bin/env perl6

use v6.d;

sub MAIN(Str :$string = '  hello world', Regex :$regex = rx/ <[ea]>l /) {
    say last-word($string, $regex);
}

sub last-word(Str $string, Regex $regex) {
    return ($string.split(" ").reverse.grep: { $_ ~~ $regex }).[0];
}
