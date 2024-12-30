#!/bin/sh

perl -E 'say join q{},sort{"$b$a" cmp "$a$b"}@ARGV' "$@"
