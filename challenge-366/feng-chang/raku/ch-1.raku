#!/bin/env raku

unit sub MAIN(*@array where @array.all ~~ /^ <[a..z]>* $/);

my $word = @array.pop;
put +@array.grep({ $word.match: /^$_/ });
