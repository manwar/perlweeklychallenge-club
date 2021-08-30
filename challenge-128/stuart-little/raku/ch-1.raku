#!/usr/bin/env raku
use v6;

# run <script> <space-separated binary words, with one word representing each row>

my $tup = (((0..^@*ARGS.elems) X (0..^@*ARGS.elems)).grep({ $_[0] <= $_[1]}) X ((0..^@*ARGS[0].chars) X (0..^@*ARGS[0].chars)).grep({ $_[0] <= $_[1] })).grep( -> $pr { @*ARGS[$pr[0][0]..$pr[0][1]].map( -> $str {$str.substr($pr[1][0], 1+$pr[1][1]-$pr[1][0])} ) !~~ /1/ }).max({ ($_[1][1]-$_[1][0]+1)*($_[0][1]-$_[0][0]+1) });

say (('0' x ($tup[1][1] - $tup[1][0] + 1)) xx ($tup[0][1] - $tup[0][0] + 1)).join("\n")
