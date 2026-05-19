#!/bin/sh

perl -E 'my@a=split/\s+/,$ARGV[0];my@b=split/\s+/,$ARGV[1];say join(q{},@a)eq join("",@b)?"true":"false"' "$@"
