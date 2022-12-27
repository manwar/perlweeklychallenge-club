#!/bin/sh

raku -e 'say @*ARGS.sort( { ($^a == 0) ?? 1 !! ( ($^b == 0) ?? -1 !! 0 )  } )' $@
