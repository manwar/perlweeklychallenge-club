#!/usr/bin/env raku
use Test;

is echo-chamber("abca"),  "abbcccaaaa";
is echo-chamber("xyz"),   "xyyzzz";
is echo-chamber("code"),  "coodddeeee";
is echo-chamber("hello"), "heelllllllooooo";
is echo-chamber("a"),     "a";

sub echo-chamber($str)
{
    $str.subst(/(.)/, { $0 x $0.to }, :g)
}
