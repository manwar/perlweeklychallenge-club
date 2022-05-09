#!/bin/sh

raku -e '@*ARGS.combinations(2).map({ [+&] $_ }).sum.say;' $@
