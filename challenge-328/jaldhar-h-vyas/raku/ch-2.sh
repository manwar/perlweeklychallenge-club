#!/bin/sh

raku -e '$_=@*ARGS[0];while s/((<[a..z]>){}$($0.uc))||((<[A..Z]>){}$($0.lc))// {};.say' "$@"
