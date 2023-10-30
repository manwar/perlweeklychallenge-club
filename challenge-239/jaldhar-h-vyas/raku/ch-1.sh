#!/bin/sh

raku -e 'say @*ARGS[0].split(q{, }).join eq @*ARGS[1].split(q{, }).join' "$@"