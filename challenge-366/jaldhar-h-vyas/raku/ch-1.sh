#!/bin/sh

raku -e 'my $s=@*ARGS.shift;@*ARGS.grep({$s.index($_)~~0}).elems.say' "$@"
