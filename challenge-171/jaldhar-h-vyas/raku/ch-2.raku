#!/usr/bin/raku

sub compose(&f, &g) {

    return sub (*@args) { &f(&g(@args)); };
}

sub square(Int $x) {
    return $x * $x;
}

sub sum(*@args) {
    return [+] @args;
}

say compose(&square, &sum)(1,2,3);
