#!/bin/sh

raku -e 'say @*ARGS[0].comb.map({.ord}).sum!%%2' "$@"
