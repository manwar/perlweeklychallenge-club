#!/bin/sh

raku -e 'say ([>=] @*ARGS) || ([<=] @*ARGS) ?? 1 !! 0;' $@