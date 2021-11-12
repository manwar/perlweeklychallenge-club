#!/bin/sh

raku -e '(1 .. @*ARGS[0]).grep({ $_ !~~ /1/ }).elems.say;' $@
