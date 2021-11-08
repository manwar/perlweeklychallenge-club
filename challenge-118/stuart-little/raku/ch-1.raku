#!/usr/bin/env raku
use v6;

# run <script> <number>

say @*ARGS[0].Int.base(2).Str.grep({ $_ eq $_.flip }).elems;
