#!/usr/bin/env raku
use v6;

# run <script> <number>

say parse-base(sprintf("%04b", @*ARGS[0] +& 15) ~ sprintf("%04b", @*ARGS[0] +> 4 +& 15),2)
