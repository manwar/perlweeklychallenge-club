#!/bin/sh

raku -e '@*ARGS.shift.subst(/(.)/,{$0.uc eq$0??$0.lc!!$0.uc},:g).say' "$@"
