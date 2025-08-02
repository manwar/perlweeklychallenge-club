#!/bin/sh

raku -e '([*] @*ARGS).sign.say;' "$@"
