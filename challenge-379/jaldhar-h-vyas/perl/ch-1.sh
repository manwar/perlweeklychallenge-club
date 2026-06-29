#!/bin/sh

perl -E 'my@a;for my$c(split//,shift){unshift@a,$c}say join q{},@a' "$@"
