#!/usr/bin/env raku

# [Adelops alloquy beefily begorry billowy egilops]

say "/usr/share/dict/words".IO.words

.hyper(batch => 10_000, degree => $*KERNEL.cpu-cores)

.grep({ $_ eq .comb.collate.join }).classify({ .chars }).max.value;
