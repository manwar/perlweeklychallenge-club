#!/usr/bin/env raku
use v6;

# run <script> <left1 right1 left2 right2 ...>

say @*ARGS.map(*.Int).rotor(2).combinations(2).grep({ ($_[1][1]-$_[0][0])*($_[1][0]-$_[0][1]) <= 0 }).map(*.[1]).unique
