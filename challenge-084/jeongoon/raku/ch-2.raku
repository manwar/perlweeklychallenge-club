#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

# modifed from #077/ch-2.raku
sub USAGE {
    say "Usage:";
    say '    echo -e "[1 0 1][0 1 0][1 0 1]" | raku ch-2.raku',"\n";
    say "# or input ending with EOF (Ctrl-D or Ctrl-Z)";
    say "# you might need to filter the STDERR to get only answer.";
}

#================================================================
# PLEASE HAVE A LOOK ch-2.commented.raku FOR DETAILS
#================================================================

unit sub MAIN;

say "Input: (Ctrl-D or Ctrl-Z to finish to input.)";
my @lines = $*IN.lines;                     # read lines from STDIN

my @matrix =
@lines.elems < 2 # one row doesn't make any retangle
?? (
     <1 1 0 1>,
     <1 1 0 0>,
     <0 1 1 1>,
     <1 0 1 1>  ) # example #2

!! @lines.
map( |*.split( /"]" \s* "\n"* | "\n"/  ) ). # split rows by newline or `]'
map( -> $ln { next if $ln eq "";            # skip empty line
              S:g/ '[' || \s+ //.comb.cache # remove unused chars.
                 with $ln } );

with @matrix {
    say "{.Array}" for $_;
    say "";

    (^.elems).
    map( -> $r {
               .[$r].pairs.grep( *.value == 1, :k ).
               combinations(2).
               map({( $_, $r )}).Slip
           } ).
    classify( {.[0].Str} ).
    values.
    map( { .combinations(2).cache.
           grep( { ([-] .[0;0].reverse) == ([-] .[*;1].reverse) } ).Slip
         } ).
    elems.
    say;
}
