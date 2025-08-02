#!/bin/sh

raku -e '@*ARGS.sort({"$^b$^a" cmp "$^a$^b"}).join.say' "$@"
