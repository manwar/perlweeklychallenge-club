#!/usr/bin/env perl6
use v6;

my %*SUB-MAIN-OPTS=:named-anywhere,;
sub MAIN(
    Str :f(:$file),
    *@LETTERS,
    ) {
    for $file.IO.lines.grep({ spl($_.lc,@LETTERS) }) {.say}
}

sub spl($word,@ltrs) { return ($word.comb.Bag (-) @ltrs).elems == 0 }
