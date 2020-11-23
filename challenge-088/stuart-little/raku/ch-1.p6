#!/usr/bin/env perl6
use v6;

sub skipprod(@a) { @a.keys.map({ @a.keys.grep(* !~~ $_) }).map({ [*] @a[@($_)] }) }

say @*ARGS.map(*.Int).&skipprod

# run as <script> <space-separated array entries>
