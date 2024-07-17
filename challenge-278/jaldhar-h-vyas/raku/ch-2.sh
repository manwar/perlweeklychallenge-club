#!/bin/sh

raku -e 'say S|(.+$(@*ARGS[1]))?(.+)|$(($0//q{}).split(q{}).sort.join~($1//q{}))| with @*ARGS[0]' "$@"
