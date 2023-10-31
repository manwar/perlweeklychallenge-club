#!/bin/sh

raku -e 'say q{(},@*ARGS.map({@*ARGS[$_]}).join(q{, }),q{)}' "$@"