#!/bin/sh

raku -e '@*ARGS.map({.words.elems}).max.say' "$@"
