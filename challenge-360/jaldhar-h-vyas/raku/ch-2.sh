#!/bin/sh

raku -e '@*ARGS[0].words.sort({$^a.uc cmp $^b.uc}).join(q{ }).say' "$@"
