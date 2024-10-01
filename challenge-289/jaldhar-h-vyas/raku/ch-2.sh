#!/bin/sh

raku -e '@*ARGS[0].subst(/(\w)(\w+)(\w)/,{$0~$1.comb.pick(*).join~$2},:g).say' "$@"
