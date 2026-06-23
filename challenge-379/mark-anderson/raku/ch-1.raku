#!/usr/bin/env raku
use Test;

is reverse-string(Empty.Str), Empty.Str;
is reverse-string("reverse the given string"), "reverse the given string".flip;
is reverse-string("Perl is Awesome"), "Perl is Awesome".flip;
is reverse-string("v1.0.0-Beta!"), "v1.0.0-Beta!".flip;
is reverse-string("racecar"), "racecar";

multi reverse-string($s where $s.chars < 2) { $s                             }
multi reverse-string($s)                    { [~] $s.comb[$s.chars.pred...0] }
