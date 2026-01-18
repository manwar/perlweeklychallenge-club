#!/bin/sh

raku -e '(@*ARGS[0]/2).round.say' "$@"
