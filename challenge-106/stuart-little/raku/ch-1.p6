#!/usr/bin/env perl6
use v6;

# run <script> <space-separated numbers>

say max @*ARGS.map(*.Int).sort.rotor(2 => -1).map({ $_[1]-$_[0] }).max, 0
