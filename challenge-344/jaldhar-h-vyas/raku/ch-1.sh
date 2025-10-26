#!/bin/sh

raku -e 'my $x=@*ARGS.shift;say q{(},($x+@*ARGS.join).comb.join(q{, }),q{)}' "$@"
