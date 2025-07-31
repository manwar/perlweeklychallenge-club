#!/bin/sh

raku -e '@*ARGS[0].split(q{-}).map({$_.Int.base(2)}).join(q{-}).say' "$@"
