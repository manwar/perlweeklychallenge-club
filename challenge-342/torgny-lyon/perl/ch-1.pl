#!/usr/bin/perl

use v5.36;

use Test::More tests => 5;

use List::Util qw(mesh);

sub balance_string {
    my @letters = sort $_[0] =~ /[a-z]/g;
    my @digits  = sort $_[0] =~ /\d/g;
    if (@digits == @letters) {
        return join q{}, mesh \@digits, \@letters;
    } elsif (@digits == @letters + 1) {
        return join q{}, grep { defined } mesh \@digits, \@letters;
    } elsif (@letters == @digits + 1) {
        return join q{}, grep { defined } mesh \@letters, \@digits;
    }
    q{};
}

is(balance_string("a0b1c2"),  "0a1b2c");
is(balance_string("abc12"),   "a1b2c");
is(balance_string("0a2b1c3"), "0a1b2c3");
is(balance_string("1a23"),    q{});
is(balance_string("ab123"),   "1a2b3");
