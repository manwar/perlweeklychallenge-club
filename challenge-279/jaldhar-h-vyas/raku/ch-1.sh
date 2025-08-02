#!/bin/sh

raku -e '%(@*ARGS[1].words Z=>@*ARGS[0].words).sort.map({$_.value}).join.say' "$@"
