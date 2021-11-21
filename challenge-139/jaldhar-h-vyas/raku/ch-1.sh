#!/bin/sh

raku -e 'say @*ARGS ~~ @*ARGS.sort({ $^a <=> $^b }) ?? 1 !! 0' $@