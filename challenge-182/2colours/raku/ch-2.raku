#!/usr/bin/env raku

my @files = $*IN.lines;
[Zeq] @files>>.split: '/' andthen .toggle: *.so andthen .Int andthen '/' ~ @files[0].split('/')[1..^$_].join('/') andthen .say;
