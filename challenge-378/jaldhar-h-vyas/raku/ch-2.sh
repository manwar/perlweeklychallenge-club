#!/bin/sh

raku -e 'my @a=@*ARGS[^3].map({.trans([q{a}..q{j}]=>[0..9])});say @a[0]+@a[1]==@a[2]' "$@"
