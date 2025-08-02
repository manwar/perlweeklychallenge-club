#!/bin/sh

perl -E '$ARGV[0]=~s{(.+$ARGV[1])(.+)}{(join q{},sort split//, $1).$2}e;say $ARGV[0]' "$@"
