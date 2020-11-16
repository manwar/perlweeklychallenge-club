#!/usr/bin/env perl6
use v6;

(1..@*ARGS[0].Int).combinations(@*ARGS[1].Int).say

# run as <script> <number> <combination size>
