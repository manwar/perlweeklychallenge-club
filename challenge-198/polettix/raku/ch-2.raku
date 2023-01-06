#!/usr/bin/env raku
sub prime-count ($n) { (2 ... $n).grep({.is-prime}).elems }
put prime-count((@*ARGS[0] // 10) - 1);
