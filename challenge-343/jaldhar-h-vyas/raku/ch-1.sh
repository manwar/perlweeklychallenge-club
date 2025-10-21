#!/bin/sh

raku -e '@*ARGS.map({(0-$_).abs}).sort({$^a <=> $^b})[0].say' "$@"
