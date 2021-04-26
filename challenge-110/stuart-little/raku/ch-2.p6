#!/usr/bin/env perl6
use v6;

# run <script> <path-to-file or nothing>
# defaults to text at the bottom if no file is entered

my @lines = (@*ARGS.elems) ?? (@*ARGS[0].IO.lines) !! ($=finish.lines);

my @transpLines = (zip @lines.map(*.split(/\,\s*/))).map(*.join(','));
for (@transpLines) {.say};

=finish
name,age,sex
Mohammad,45,m
Joe,20,m
Julie,35,f
Cristina,10,f
