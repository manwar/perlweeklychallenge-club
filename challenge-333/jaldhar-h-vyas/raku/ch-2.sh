#!/bin/sh

raku -e 'say q{(},@*ARGS.map({$_+0??$_!!|(0,0)})[^@*ARGS.elems].join(q{, }),q{)}' "$@"
