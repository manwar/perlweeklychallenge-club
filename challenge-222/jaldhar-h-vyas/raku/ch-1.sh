#!/bin/sh

raku -e '(@*ARGS Z== @*ARGS.sort).grep({$_}).elems.say' $@
