#!/bin/sh

raku -e '@*ARGS[0].match(/<(\d\d)>\#||<(\d)>/,:g).map({chr(0x60+$_)}).join(q{}).say' "$@"
