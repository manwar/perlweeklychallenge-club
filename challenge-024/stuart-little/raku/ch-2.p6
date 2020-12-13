#!/usr/bin/env perl6
use v6;

# run as <script> <space-separated list of files>

sub rev_idx(@files) {
    my @words=@files.map({ $_.IO.comb(/\w+/) }).map(|*).Set.keys.map(*.lc).unique.sort;
    @words.map({ $_ => @files.grep( -> $file { $file.IO.slurp.contains($_) }) })
}

for rev_idx(@*ARGS) {.say}
