#!/bin/sh

raku -e 'my @a=@*ARGS.sort.unique;say @a[*-3]//@a[*-1]' "$@"
