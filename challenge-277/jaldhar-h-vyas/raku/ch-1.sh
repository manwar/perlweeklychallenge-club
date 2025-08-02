#!/bin/sh

raku -e '(@*ARGS[0].words.Bag.grep({ $_.value==1})∩@*ARGS[1].words.Bag.grep({ $_.value==1})).elems.say' "$@"
