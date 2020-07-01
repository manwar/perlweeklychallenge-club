#! /usr/bin/env raku

unit sub MAIN (Int $m where $m > 0, Int $n where $n > 0);

say "[ ", (1..$m).combinations($n).map({ "[{ $_.join(",") }]" }).join(", "), " ]";
