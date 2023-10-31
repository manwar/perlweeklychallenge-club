#!/bin/sh

raku -e 'say @*ARGS[0] eq @*ARGS[1..*].map({$_.substr(0,1).lc}).join(q{})' "$@"