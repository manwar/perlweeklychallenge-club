#!/usr/bin/env raku

use Test;

my %examples = (
    "abca"  => "abbcccaaaa",
    "xyz"   => "xyyzzz",
    "code"  => "coodddeeee",
    "hello" => "heelllllllooooo",
    "a"     => "a",
);

for %examples.keys -> $input {
    is echo-chamber($input), %examples{$input};
}

done-testing;

sub echo-chamber($str) {
    $str.subst: :g, /(.)/, { $0 x ($/.from + 1) };
}
