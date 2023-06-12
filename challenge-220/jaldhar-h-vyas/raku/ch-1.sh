#!/bin/sh

raku -e 'say q{("}, ([∩] @*ARGS.map({ $_.comb.map({ $_.lc }) })).keys.sort.join(q{", "}), q{")}' $@