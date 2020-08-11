#! /usr/bin/env raku

my $gapful := (100 .. *).grep( { $_ %% ( .substr(0,1) ~ .substr(*-1,1) ) });

say "First 20 Gapful numbers: { $gapful[^20].join(',') }.";
