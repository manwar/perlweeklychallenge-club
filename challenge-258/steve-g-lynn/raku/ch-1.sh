#!/bin/sh

raku -e 'say +@*ARGS.grep({$_.chars %% 2})' $@
