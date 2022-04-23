#! /usr/bin/env raku

unit sub MAIN (:d(:$dictionary) where $dictionary.IO.r = 'dictionary.txt');

.say for $dictionary.IO.lines.grep({ $_ eq $_.comb.sort.join }).sort( { $^b.chars <=> $^a.chars });
