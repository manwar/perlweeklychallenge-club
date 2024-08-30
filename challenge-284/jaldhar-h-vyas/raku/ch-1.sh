#!/bin/sh

raku -e 'my %h=@*ARGS.classify({$_});say (%h.keys.grep({$_==%h{$_}.elems}).sort)[*-1]//-1' "$@"