#! /usr/bin/env raku

unit sub MAIN ($sentence where $sentence.chars > 0, *@keys where @keys.elems > 0, :v(:$verbose));

my @words   = $sentence.words;
my @lc_keys = @keys>>.lc;

say ": Words: { @words.map({ "'$_'"}).join(", ")}" if $verbose;

my @fully = @words.map({ $_.lc.contains(any(@lc_keys)) ?? 0 !! 1 });

say ": Fully: { @fully.join(", ") }" if $verbose;

say @fully.sum;
