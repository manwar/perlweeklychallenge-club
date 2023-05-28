#!/bin/sh

raku -e '@*ARGS.combinations(3).map({ [*] $_ }).max.say;' $@