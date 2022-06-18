#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.d;

# 1: Abecedarian Words
#  Select words spelled with chars in alphabetic order
# from this one-word-per-line file and sort by word length descending.

# Do not accept a lossy loop.  All is best DRY.

$?FILE.IO.parent(4).add("data/dictionary.txt").lines(:chomp).grep( {
        .comb.sort.join eq $_ }
    ).sort(
        { $^b.chars <=> $^a.chars }
    ).join( "\n").say;

