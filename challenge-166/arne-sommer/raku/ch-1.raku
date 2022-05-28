#! /usr/bin/env raku

unit sub MAIN
(
  :d(:$dictionary) where $dictionary.IO.r = 'dictionary.txt',
  :p(:$pure),
);

my @dict = $pure
  ?? $dictionary.IO.lines.grep( 1 < *.chars <= 8 ).grep( * ~~ /^<[abcdeflo]>+$/)
  !! $dictionary.IO.lines.grep( 1 < *.chars <= 8 ).grep( * ~~ /^<[abcdefilost]>+$/);

@dict.map({ say "0x" ~ TR/olist/01157/ });
