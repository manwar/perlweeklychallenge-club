#!/bin/sh
perl -E '$_ = lc shift; tr/a-z//cd; @x = split //; $c=7; while (@x){ for ($i = 0; $i <= $#x; $i += $c) { print splice @x, $i, 1} $c--; print " "} say ""' "The quick brown fox jumps over the lazy dog"
