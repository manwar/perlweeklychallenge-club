#!/usr/bin/env raku
use Test;

is text-justifier("Hi", 5),    "*Hi**";
is text-justifier("Code", 10), "***Code***";
is text-justifier("Hello", 9), "**Hello**";
is text-justifier("Perl", 4),  "Perl";
is text-justifier("A", 7),     "***A***";
is text-justifier("", 5),      "*****";

sub text-justifier($s, $w)
{
    ('*' x $w).subst(/"{'*' x $s.chars}"/, $s, :c(($w - $s.chars) div 2))
}
