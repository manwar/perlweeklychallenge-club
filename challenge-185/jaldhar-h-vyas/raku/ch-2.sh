#!/bin/sh

raku -e '@*ARGS.map({ $_.subst(/<[a..z0..9]>/, "x", :nth(1..4)); }).say;' $@