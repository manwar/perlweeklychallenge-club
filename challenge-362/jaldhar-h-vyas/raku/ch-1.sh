#!/bin/sh

raku -e 'my $i=1;@*ARGS[0].comb.map({$_ x$i++}).join.say' "$@"
