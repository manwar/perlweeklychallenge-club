#!/bin/sh

raku -e 'say S/(^.+?$(@*ARGS[1]))/$($0.flip)/ given @*ARGS[0]' "$@"