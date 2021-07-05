#!/usr/bin/env raku
use v6;

sub missing-row ($file) {
   constant All = set(1 .. 15);
   (All (-) set($file.IO.lines.map({+ S/^ (\d+) .*/$0/}))).keys;
}

put missing-row(@*ARGS[0]);
