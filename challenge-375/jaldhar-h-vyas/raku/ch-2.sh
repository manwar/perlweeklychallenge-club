#!/bin/sh

raku -e 'my ($n,$k)=@*ARGS;(0..$n.chars-$k).map({$n.substr($_,$k)}).grep({$n%%$_}).elems.say' "$@"
