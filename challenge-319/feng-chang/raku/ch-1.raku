#!/bin/env raku

unit sub MAIN(*@words);

my $vowel = <a e i o u>.any;
put +@words.grep({ .starts-with($vowel) || .ends-with($vowel) });
