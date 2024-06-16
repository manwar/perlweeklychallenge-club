#!/bin/sh

raku -e '@*ARGS[0].match(/(b)$0<[-a]>*/).so.say' "$@"
