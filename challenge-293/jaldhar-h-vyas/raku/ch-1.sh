#!/bin/sh

raku -e 'my %a;@*ARGS.map({[.split(q{ })].sort.join}).map({%a{$_}++});%a.values.max.say' "$@"
