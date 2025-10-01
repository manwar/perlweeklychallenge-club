#!/bin/sh

raku -e '@*ARGS[0].words.grep({$_!~~m:i/@(@*ARGS[1].comb)/}).elems.say' "$@"