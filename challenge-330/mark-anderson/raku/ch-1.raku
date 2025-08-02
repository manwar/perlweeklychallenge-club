#!/usr/bin/env raku
use Test;

is clear-digits("cab12"),  "c";
is clear-digits("xy99"),    Empty.Str;
is clear-digits("pa1erl"), "perl";

sub clear-digits($s is copy)
{
    loop
    {
        $s .= subst(/ (<lower>+) (<digit>+) <?{ $0.chars == $1.chars }> /, :g);
        return $s unless $/
    }
}
