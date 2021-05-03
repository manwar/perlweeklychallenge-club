#!/usr/bin/env raku

# [Adelops alloquy beefily begorry billowy egilops]

.say for "/usr/share/dict/words".IO.words

.hyper(batch => 10_000, degree => $*KERNEL.cpu-cores)

.grep({ [le] .fc.comb }).classify({ .chars }).max.value;
