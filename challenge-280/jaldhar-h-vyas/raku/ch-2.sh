#!/bin/sh

raku -e '@*ARGS[0].subst(/\|.+?\||<-[*]>/,q{},:g).chars.say' "$@"
