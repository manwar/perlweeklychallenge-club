#!/usr/bin/perl

use v5.36;

use Test::More tests => 5;

sub reverse_prefix {
    my $i = index($_[0], $_[1]) + 1;
    reverse(substr $_[0], 0, $i) . substr $_[0], $i;
}

is(reverse_prefix("programming", "g"), "gorpramming");
is(reverse_prefix("hello",       "h"), "hello");
is(reverse_prefix("abcdefghij",  "h"), "hgfedcbaij");
is(reverse_prefix("reverse",     "s"), "srevere");
is(reverse_prefix("perl",        "r"), "repl");
