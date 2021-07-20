#!/usr/bin/env raku
use v6;

# run <script> <space-separated numbers>

say ([\+] @*ARGS.map(*.Num)) Z/ (1..*);
