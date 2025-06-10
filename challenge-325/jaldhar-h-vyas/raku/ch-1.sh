#!/bin/sh

raku -e '@*ARGS.join~~m:g/(<[1]>+)/;say (($/.sort.tail||q{}).chars' "$@"
