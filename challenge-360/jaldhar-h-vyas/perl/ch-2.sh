#!/bin/sh

perl -E 'say join q{ },sort{uc$a cmp uc$b}split/\s+/,shift' "$@"
