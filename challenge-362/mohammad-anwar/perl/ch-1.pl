#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my %examples = (
    "abca"  => "abbcccaaaa",
    "xyz"   => "xyyzzz",
    "code"  => "coodddeeee",
    "hello" => "heelllllllooooo",
    "a"     => "a",
);

is echo_chamber($_), $examples{$_} for keys %examples;

done_testing;

sub echo_chamber {
    my $str = shift;
    $str =~ s/(.)/ $1 x (pos($str) + 1) /ge;
    return $str;
}
