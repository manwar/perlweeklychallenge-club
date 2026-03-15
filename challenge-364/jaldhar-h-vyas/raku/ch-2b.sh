#!/bin/sh

raku -e '@*ARGS[0].subst(/\(al\)/,"al",:g).subst(/\(\)/,"o",:g).say' "$@"
