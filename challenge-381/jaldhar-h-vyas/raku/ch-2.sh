#!/bin/sh

raku -e 'my@a=@*ARGS.sort({$^a <=>$^b});@a.grep({$_!=@a[0]&&$_!=@a[*-1]}).elems.say' "$@"
