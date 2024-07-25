#!/bin/sh

raku -e 'say @*ARGS[0].match(/(<[aeiou]>)/,:g).elems%%2' "$@"
