#!/usr/bin/perl
use v5.38;
use Parse::RecDescent;

my $str = shift // die "Need a number\n";

my $grammar = q{
    startrule: number

    number: decimal1
          | decimal2
          | integer
    decimal1: sign(?) digit(s) decimalpoint
    decimal2: sign(?) decimalpoint digit(s)
    integer: sign(?) digit(s) exponent(?)

    decimalpoint: '.'
    exponent: /[eE]/ integer
    sign: /[-+]/
    digit: /\d/
};

my $number = Parse::RecDescent->new($grammar)->startrule(\$str);
say 0+(length $str) ? 'false' : 'true';
