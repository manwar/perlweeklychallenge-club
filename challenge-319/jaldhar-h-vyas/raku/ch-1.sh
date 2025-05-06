#!/bin/sh

raku -e '@*ARGS.grep({$_.match(/^<[aeiou]>||<[aeiou]>$/)}).elems.say' "$@"
