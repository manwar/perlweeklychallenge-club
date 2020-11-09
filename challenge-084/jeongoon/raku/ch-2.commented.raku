#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

=begin test-example

# modifed from #077/ch-2.raku
sub USAGE {
    say "Usage:";
    say '    echo -e "[1 0 1][0 1 0][1 0 1]" | raku ch-2.raku',"\n";
    say "# or input ending with EOF (Ctrl-D or Ctrl-Z)";
    say "# you might need to filter the STDERR to get only answer.";
}

unit sub MAIN;

echo '[101][110][011] ' | raku jeongoon/raku/ch-2.raku
# -> 0
echo '[1101][1100][0111][1011]' | raku jeongoon/raku/ch-2.raku # example #2
# -> 4

=end test-example

say "Input: (Ctrl-D or Ctrl-Z to finish to input.)";
my @lines = $*IN.lines;                     # read lines from STDIN
my @matrix =
( @lines.elems < 2

  ?? ( <1 1 0 1>,
       <1 1 0 0>,
       <0 1 1 1>,
       <1 0 1 1> ) # example #2

  !! @lines.
  map( |*.split( /"]" \s* "\n"* | "\n"/  ) ). # split rows by newline or `]'
  map( -> $ln { next if $ln eq "";            # skip empty line
                S:g/ '[' || \s+ //.comb.cache # remove unused chars.
                   with $ln } )
);

with @matrix {
    say "A matrix recognized as ..\n";
    say "{.Array}" for $_;
    say "";

    # part1: find the all possible horizontal lines(pairs of two points)
    (^.elems).
    map( -> $r {
               .[$r].pairs.
               grep( *.value == 1, :k ).      # filter point(has value of 1)
               combinations(2).               # make pairs of two column number
               map({( $_, $r)}).Slip          # as line(two points), row number
           } ).

    # part2: group the lines which starts at the same point and has the same len
    classify( -> $rec
              {$rec[0].Str},                  # key:  two points as *pair*
              # note: if we don't pair, classify() will smartly make trees
              #       which, I don't want to here.
            ).

    # part3: find squares
    #        (check two lines has distance as same as the length of line)

    ## only interested in values (the list of (distance between pts, row num))
    values.
    map(
        { .combinations(2).cache.             # -> combinations of two lines
          grep( {  ([-] .[0;0].reverse)       # length of a line
                   ==                         #    is same as
                   ([-] .[*;1].reverse)       # distance between two lines
               } ).Slip
        } ).

    # explaination
    map(
        {
            FIRST { $*ERR.say("Explanations:\n") }
            $*ERR.say( ++$,":{.raku}" );
            $*ERR.say( " ☞ both lines have length of "
                       ~ "{[-] .[0][0].reverse} "
                       ~ " and {[-] .[*;1].reverse} away from each other.\n" );
            LAST { $*ERR.print( "∴ " ) }
            .self }).
    elems.
    say;
}
