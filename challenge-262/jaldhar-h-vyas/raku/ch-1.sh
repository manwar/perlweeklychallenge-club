#!/bin/sh

raku -e '@*ARGS.classify({if $_ < 0 {q{n}} elsif $_ > 0 {q{p}}else{q{0}}},:into(my %a));max(%a<n>.elems,%a<p>.elems).say' "$@"