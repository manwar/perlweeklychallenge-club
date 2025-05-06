#!/bin/sh

raku -e '@*ARGS.classify({$_ < 0 ?? "n"!!$_ > 0??"p"!!"z" },:into(my %a));(%a<p>.elems,%a<n>.elems).max.say' "$@"

