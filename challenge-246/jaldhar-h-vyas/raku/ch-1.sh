#!/bin/sh

raku -e '(1 .. 49).pick(6).join("\n").say' "$@"
