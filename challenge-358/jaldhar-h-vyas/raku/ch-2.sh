#!/bin/sh

raku -e '@*ARGS[0].comb.map({("a".ord+($_.ord-"a".ord+@*ARGS[1])%26).chr}).join.say' "$@"
