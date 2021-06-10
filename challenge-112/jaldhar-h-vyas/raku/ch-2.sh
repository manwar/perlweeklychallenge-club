#!/bin/sh

raku -e '(0, 1, -> $a, $b { $a + $b } ... *)[@*ARGS[0] + 1].say;' $@