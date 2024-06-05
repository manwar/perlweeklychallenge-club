#!/bin/sh

raku -e 'say @*ARGS[0].subst(".", "[.]",:g)' "$@"
