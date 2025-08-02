#!/usr/bin/env raku

use v6.d;

sub clear-digits(Str $str --> Str) {
    my Str $result = $str;
    while $result ~~ /<lower>\d/ {
        $result ~~ s/<lower>\d//;
    }
    $result;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is clear-digits("cab12"), "c", 'works for "cab12"';
    is clear-digits("xy99"), "", 'works for "xy99"';
    is clear-digits("pa1erl"), "perl", 'works for "pa1erl"';
}

#| Take user provided number like "pa1erl"
multi sub MAIN(Str $str) {
    say clear-digits($str);
}
