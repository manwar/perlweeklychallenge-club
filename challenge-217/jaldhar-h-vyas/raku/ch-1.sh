#!/bin/sh

raku -e "@*ARGS.map({ .split(/','/) }).flat.sort({ $^a <=> $^b })[2].say;" $@
