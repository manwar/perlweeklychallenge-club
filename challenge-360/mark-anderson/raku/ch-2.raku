#!/usr/bin/env raku
use Test;

is word-sorter("The quick brown fox"),              "brown fox quick The";
is word-sorter("Hello    World!   How   are you?"), "are Hello How World! you?";
is word-sorter("Hello"),                            "Hello";
is word-sorter("Hello, World! How are you?"),       "are Hello, How World! you?";
is word-sorter("I have 2 apples and 3 bananas!"),   "2 3 and apples bananas! have I";

sub word-sorter($str)
{
    $str.words.sort(*.lc).Str
}
