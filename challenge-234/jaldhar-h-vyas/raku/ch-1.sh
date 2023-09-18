#!/bin/sh

raku -e 'say q{(},([∩] @*ARGS.map({$_.comb.BagHash})).map({|($_.key x $_.value).comb}).sort.map({"\"$_\""}).join(q{, }),q{)}' "$@"
