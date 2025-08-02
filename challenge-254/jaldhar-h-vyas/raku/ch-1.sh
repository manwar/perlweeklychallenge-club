#!/bin/sh

raku -e 'say (@*ARGS[0]**(1/3)).round(0.001) %% 1' "$@"