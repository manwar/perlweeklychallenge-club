#!/bin/sh

raku -e '(0 .. @*ARGS.end).combinations(2).grep({@*ARGS[@$_[0]]>2*@*ARGS[@$_[1]]}).elems.say;' "$@"
