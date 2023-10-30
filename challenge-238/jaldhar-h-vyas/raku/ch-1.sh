#!/bin/sh

raku -e 'my $t=0;say q{(},@*ARGS.map({$t+=$_}).join(q{, }),q{)}' "$@"