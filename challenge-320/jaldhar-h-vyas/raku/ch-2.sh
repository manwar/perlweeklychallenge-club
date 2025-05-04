#!/bin/sh

raku -e 'say @*ARGS.sum-@*ARGS.map({ $_.comb }).flat.sum' "$@"

