#!/bin/sh

raku -e '@*ARGS.grep({$_.chars%%2}).elems.say' "$@"