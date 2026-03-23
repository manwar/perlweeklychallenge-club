#!/usr/bin/env raku

use Test;

my @examples = [
    {
        str   => "apple",
        array => [ "a", "ap", "app", "apple", "banana" ],
        out   => 4
    },
    {
        str   => "bird",
        array => [ "cat", "dog", "fish" ],
        out   => 0
    },
    {
        str   => "hello",
        array => [ "hello", "he", "hell", "heaven", "he" ],
        out   => 4
    },
    {
        str   => "coding",
        array => [ "", "code", "coding", "cod" ],
        out   => 3
    },
    {
        str   => "program",
        array => [ "p", "pr", "pro", "prog", "progr", "progra", "program" ],
        out   => 7
    },
];

for @examples -> %example {
    is count-prefixes(%example<str>, %example<array>), %example<out>;
}

done-testing;

sub count-prefixes($str, @array) {
    my $count = @array.grep({ $str.starts-with($_) }).elems;
    return $count;
}
