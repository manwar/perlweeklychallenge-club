#!/usr/bin/env perl6
use v6;

sub inv_tree(@t where { log2($_.elems + 1) %% 1 }) {
    (0..(log2(@t.elems + 1)-1)).map(2 ** * - 1).map({ @t[$_ .. 2*$_].reverse }).flat
}

sub ancest($n) { $n == 0 && return ($n,); return ($n % 2) ?? (|ancest(($n-1) div 2), $n) !! (|ancest(($n-2) div 2), $n); }

sub draw_brnch(@a) {
    |@a[0..^*-1].map(*.trans(['-', 0..9] => ' ')), @a[*-1]
}

sub preord(@a) { @a == 1 && return @a; return (@a[0], |preord(@a[@a.keys.grep({($_+1).base(2) ~~ /^10/})]), |preord(@a[@a.keys.grep({($_+1).base(2) ~~ /^11/})]))}

my @fragments=@*ARGS.pairs.map({ (($_.key %% 2) ?? ('') !! ('|')) ~ "--" ~ $_.value });

my @lines=@fragments.keys.map(*.&ancest).map({ @fragments[@($_)] }).map(*.&draw_brnch).map(*.join);

for @lines.&preord {.say}

# run as <script> <space-separated tree entries, ordered as you would read them in English: left-to-right then top-to-bottom>
