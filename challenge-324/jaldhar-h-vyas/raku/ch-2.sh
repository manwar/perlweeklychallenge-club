#!/bin/sh

raku -e '@*ARGS.combinations.map({[+^] $_}).sum.say' "$@"
