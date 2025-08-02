#!/bin/sh

raku -e 'say @*ARGS.combinations(2..@*ARGS.elems).grep({([+|] @$_).base(2).ends-with(0)}).elems > 0' "$@"
