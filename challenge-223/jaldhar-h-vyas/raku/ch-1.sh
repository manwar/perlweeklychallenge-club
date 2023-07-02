#!/bin/sh

raku -e '(1 .. @*ARGS[0]).grep({.is-prime}).elems.say' $@
