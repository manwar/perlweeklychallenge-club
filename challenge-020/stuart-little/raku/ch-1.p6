#!/usr/bin/env perl6
use v6;

@*ARGS[0] ~~ m:g/(.)$0*/; say $/.map(*.Str)

# run as <script> <string>
