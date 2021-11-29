#!/bin/sh

raku -e '(1 .. @*ARGS[0] X* 1 .. @*ARGS[1]).sort({$^a <=> $^b})[@*ARGS[2] - 1].say;' $@ 