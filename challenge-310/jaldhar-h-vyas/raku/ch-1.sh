#!/bin/sh

raku -e 'say q{(},([∩] @*ARGS».words).keys.sort({$^a <=> $^b}).join(q{, }),q{)}' "$@"