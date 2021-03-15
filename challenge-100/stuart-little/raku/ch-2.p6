#!/usr/bin/env perl6
use v6;

sub redStep(@row1,@row2) {
    (Inf,|@row1,Inf).rotor(2 => -1).map(*.min) Z+ @row2
}

sub collapseTriang(*@rows) {
    @rows.reduce(&redStep).min
}

say collapseTriang(@*ARGS.map(*.Int).rotor(1..*).map(*.Array).Array)

=finish

run <script> <space-separated array entries, left-to-right and top-to-bottom>

e.g. <script> 1 2 4 6 4 9 5 1 7 2

will pass the triangle

            1
           2 4
          6 4 9
         5 1 7 2
