#!/bin/sh

raku -e '(0..@*ARGS-1).combinations(2).grep({@*ARGS[@_[0]]==@*ARGS[@_[1]]}).elems.say' $@
