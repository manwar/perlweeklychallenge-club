#!/bin/sh

raku -e '@*ARGS[0].words.map({$_.chars <3??$_.lc!!$_.tclc }).join(q{ }).say' "$@"
