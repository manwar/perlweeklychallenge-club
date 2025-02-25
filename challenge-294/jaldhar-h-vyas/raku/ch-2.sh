#!/bin/sh

raku -e 'say q{(},@*ARGS.permutations[1].join(q{, }),q{)}' "$@"
