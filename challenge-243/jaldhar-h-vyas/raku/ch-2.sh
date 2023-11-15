#!/bin/sh

raku -e '(@*ARGS X @*ARGS).map({(@$_[0]/@$_[1]).floor}).sum.say' "$@"
