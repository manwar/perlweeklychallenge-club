#!/usr/bin/env perl6
use v6;

# run as <script> <quoted string>
# or just <script> to default to the example at https://perlweeklychallenge.org/blog/perl-weekly-challenge-029/

for ((@*ARGS) ?? @*ARGS[0] !! 'Perl {Daily,Weekly,Monthly,Yearly} Challenge')
.words
.map({ ($_ ~~ /^\{(.*)\}$/) ?? ($0.Str.split(',')) !! ($_,) })
.reduce(&infix:<X>).map(*.join(' ')) {.say}


