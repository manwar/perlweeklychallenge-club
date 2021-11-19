#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { say jort-sort(@args) ?? 1 !! 0 }
sub jort-sort (@args) { @args.sort ~~ @args }
