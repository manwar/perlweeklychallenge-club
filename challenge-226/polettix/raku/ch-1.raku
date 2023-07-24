#!/usr/bin/env raku
use v6;
sub MAIN ($s, *@i) { put $s.comb[@i].join('') }
