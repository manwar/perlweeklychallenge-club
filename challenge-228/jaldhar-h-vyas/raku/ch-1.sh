#!/bin/sh

raku -e '@*ARGS.classify({$_}).grep({.value==1}).map({.key}).sum.say' "$@"
