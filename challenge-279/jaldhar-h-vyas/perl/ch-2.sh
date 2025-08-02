#!/bin/sh

perl -E 'say $ARGV[0]=~y/aeiou//%2?"false":"true"' "$@"
