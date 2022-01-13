#!/bin/sh

raku -e '(1 ..^ @*ARGS[0]).grep({ @*ARGS[0] %% $_; }).grep({ $_.match(/ "@*ARGS[1]" $ /)}).elems.say;' $@