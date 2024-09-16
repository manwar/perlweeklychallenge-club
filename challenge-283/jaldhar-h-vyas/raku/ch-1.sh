#!/bin/sh

raku -e '@*ARGS.classify({$_}).sort({$^a.value.elems <=> $^b.value.elems})[0].key.say' "$@"