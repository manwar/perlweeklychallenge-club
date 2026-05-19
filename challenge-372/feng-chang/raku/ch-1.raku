#!/bin/env raku

unit sub MAIN(Str:D $str);

my @words = $str.words;
my $spaces = $str.chars - @words».chars.sum;
#put "spaces $spaces";
my $gap = +@words == 1 ?? 0 !! $spaces div (+@words - 1);
#put "gap $gap";
my $rem = $spaces - $gap * (+@words - 1);
#put "reminder $rem";

put "'", @words[0], @words.tail(*-1).map({ (' ' x $gap) ~ $_ }).join, ' ' x $rem, "'";
