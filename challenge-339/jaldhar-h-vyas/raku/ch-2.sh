#!/bin/sh

raku -e 'my @a=(0);for @*ARGS {@a.push(@a[*-1]+$_)};@a.max.say' "$@"