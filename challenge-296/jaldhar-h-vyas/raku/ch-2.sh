#!/bin/sh

raku -e 'my $a=@*ARGS.sum/4;say $a%%1&&@*ARGS.max <=$a' "$@"
