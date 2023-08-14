#!/bin/env raku

unit sub MAIN(*@words);

my $prefix = @words.pop;
put +@words.grep(*.starts-with($prefix));
