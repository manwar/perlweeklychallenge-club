#!/usr/bin/env perl6
use v6;

sub center(@a) { my $mlen=@a.map(*.chars).max; @a.map({ " " x (($mlen-$_.chars) div 2) ~ $_ }) }

for @*ARGS.&center {.say}

# run as <script> <space-separated strings, each enclosed in quotes if it contains whitespace>
