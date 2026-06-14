#!/bin/sh

raku -e 'my@a=(@*ARGS[0..1].join).comb;say (@a[0].ord+@a[1])%2==(@a[2].ord+@a[3])%2' "$@"
