#!//bin/sh

raku -e 'say q{(},@*ARGS.map({|.comb}).join(q{, }),q{)}' "$@"
