#!/bin/sh

perl -E 'say join q{ },map{$_=lc;length>2&&s/^(.)/\u$1/;$_}(split/\W+/,shift)' "$@"
