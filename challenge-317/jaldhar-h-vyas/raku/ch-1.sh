#!/bin/sh

raku -e '(@*ARGS.shift eq @*ARGS.map({$_.substr(0,1)}).join).so.say' "$@"

