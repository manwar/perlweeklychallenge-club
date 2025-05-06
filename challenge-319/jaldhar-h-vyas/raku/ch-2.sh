#!/bin/sh

raku -e '((@*ARGS[0].words∩@*ARGS[1].words).keys||(-1)).min.say' "$@"
