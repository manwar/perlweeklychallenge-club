#!/usr/bin/env raku

my $s := 2, { $^a * ($^a-1) + 1 }...*;

.say for $s.head(10);
