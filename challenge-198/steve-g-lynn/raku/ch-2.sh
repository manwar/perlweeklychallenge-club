#!/bin/sh

raku -e '(0..^@*ARGS[0]).grep(*.is-prime).elems.say' $@
