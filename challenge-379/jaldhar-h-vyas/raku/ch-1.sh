#!/bin/sh

raku -e 'my@a;for @*ARGS[0].comb -> $c {@a.unshift($c)};@a.join.say' "$@"
