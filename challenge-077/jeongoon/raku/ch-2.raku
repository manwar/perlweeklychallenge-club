#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

sub USAGE {
    say "Usage:";
    say 'echo -e "[O O X][X X O][X O O]" | raku ch-2.raku';
    say "# or input ending with EOF (Ctrl-D or Ctrl-Z .. or ...??? )";
}

unit sub MAIN;
my @matrix =
$*IN.lines.                                       # read lines from STDIN
map( |*.split( /"]" \s* "\n"* | "\n"/  ) ).       # split rows by newline or `]'
map( -> $l { next if $l ~~ "";                    # skip empty line
             S:g/ '[' || \s+ //.comb.cache with $l } );  # remove unused chars.

my $cnt = 0;
say "Input: (Ctrl-D or Ctrl-Z to finish to input.)";

with @matrix {
    say "{.Array.raku}" for $_;
    say "";
    for 0 .. .end -> $r {
        for 0.. .[0].end -> $c {
            next if .[$r][$c] ne 'X';
            if 1 == (-1..1).map(
                -> $dy
                { | (-1..1).map(
                        -> $dx
                        {  .[$r+$dy]:exists
                            and .[$r+$dy][$c+$dx]:exists
                                ??.[$r+$dy][$c+$dx] !!'O' })}).
            grep('X').elems {
                say "{++$cnt}: Lonely X at Row {$r+1}, Col {$c+1}";
                }
        }
    }
}
