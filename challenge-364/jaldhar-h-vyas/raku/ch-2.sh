#!/bin/sh

raku -e 'say S:g/\(al\)/al/ given (S:g/\(\)/o/ given @*ARGS[0])' "$@"
