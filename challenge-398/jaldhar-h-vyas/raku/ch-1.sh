#!/bin/sh

raku -e 'my@a=@*ARGS.grep: *%%6;say @a.elems??(@a.sum/@a.elems).round!!0' "$@"
