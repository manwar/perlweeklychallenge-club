#!/usr/bin/env perl6

.put for (0..50).grep: { $_ %% [+] .comb };
