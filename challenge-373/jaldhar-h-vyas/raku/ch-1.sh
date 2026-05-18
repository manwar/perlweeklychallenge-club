#!/bin/sh

raku -e 'my @a=@*ARGS[0].words;my @b=@*ARGS[1].words;say @a.join eq @b.join' "$@"
