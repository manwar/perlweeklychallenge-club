#!/bin/sh

raku -e 'all(@*ARGS[0].comb.Bag.values%%2).so.say' "$@"
