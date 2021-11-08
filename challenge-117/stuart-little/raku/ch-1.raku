#!/usr/bin/env raku
use v6;

# run <script> <path-to-file>

my @lines = (@*ARGS.elems) ?? (@*ARGS[0].IO.lines) !! ($=finish.lines);
((@lines.elems+1)*(@lines.elems + 2)/2 - @lines.map({ /^<-[\d]>*(\d+)/; $0.Int }).sum ).say;

=finish
11, Line Eleven
1, Line one
9, Line Nine
13, Line Thirteen
2, Line two
6, Line Six
8, Line Eight
10, Line Ten
7, Line Seven
4, Line Four
14, Line Fourteen
3, Line three
15, Line Fifteen
5, Line Five
