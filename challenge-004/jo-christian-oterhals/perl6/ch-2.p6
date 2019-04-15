#!/usr/bin/env perl6

my $letters = ( gather for 1..500 { take ('a'..'z').pick } ).BagHash;

say ([+] $letters.values) ~ " letters matches...";

for "random-2000.dict".IO.lines.sort({ rand }) -> $word {
    my $wbh = $word.lc.comb.BagHash;
    if ($wbh (<=) $letters) {
        $letters = $letters (-) $wbh;
        say "\t" ~ $word;
    }
}

say ([+] $letters.values) ~ " letters remain.";


