#!/usr/bin/env raku
use v6;

# run <script> <bit position>

say @*ARGS[0].Int +^ 2 ** (@*ARGS[1].Int-1);
