#!/bin/sh

raku -e 'say q{(},([∩] @*ARGS.map({.comb.Bag})).map({"\"{.key}\""xx.value}).sort.join(q{, }),q{)}' "$@"