#!/bin/sh

raku -e 'say bag(@*ARGS[1].comb) ⊆ bag(@*ARGS[0].comb);' $@
