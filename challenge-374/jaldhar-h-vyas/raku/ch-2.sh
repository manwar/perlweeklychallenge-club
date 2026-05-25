#!/bin/sh

raku -e '@*ARGS[0].match(/((\d)$0*)/,:g)».Str.sort({$^b <=> $^a}).first.say' "$@"
