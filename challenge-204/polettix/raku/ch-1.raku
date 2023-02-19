#!/usr/bin/env raku
use v6;
sub MAIN (*@args) { put monotonic-array(@args) ?? 1 !! 0 }

sub monotonic-array (@array) {
   ([*] @array.rotor(2 => -1).map({[-] $_}).minmax[0, *-1]) >= 0
}
