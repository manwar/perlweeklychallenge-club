#!/usr/bin/env raku

my $cycle := 4, 16, 37, 58, 89, 145, 42, 20;

multi happy($ where * == 1)          { True  }
multi happy($ where * (elem) $cycle) { False }
multi happy($_)                      { happy([+] .comb >>**>> 2) }

use Test;
is-deeply (1..*).grep(&happy).head(8).flat, (1, 7, 10, 13, 19, 23, 28, 31);
