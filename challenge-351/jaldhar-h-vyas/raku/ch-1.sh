#!/bin/sh

raku -e 'my @a=@*ARGS;@a=(@a∖(@a.min,@a.max)).keys;say @a??@a.sum/@a.elems!!0' "$@"
