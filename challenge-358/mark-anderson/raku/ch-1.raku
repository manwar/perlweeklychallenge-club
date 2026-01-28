#!/usr/bin/env raku
use Test;
plan 5;

is max-str-val(<123 45 6>),            123;
is max-str-val(<abc de fghi>),           4;
is max-str-val(<0012 99 a1b2c>),        99;
is max-str-val(<x 10 xyz 007>),         10;
is max-str-val(<hello123 2026 perl>), 2026;

grammar G
{
    rule  TOP    { [ <digits> || <alnums> ]+ { make max flat $<digits>>>.made, $<alnums>>>.made }}
    token digits {   <digit>+                { make $/.Int                                      }}
    token alnums {   <alnum>+                { make $/.chars                                    }}
}

sub max-str-val(@strings)
{
    G.parse(@strings).made
}
