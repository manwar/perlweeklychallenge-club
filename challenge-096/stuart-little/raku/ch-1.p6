#!/usr/bin/env perl6
use v6;

# run <script> <quoted string>

@*ARGS[0].words.reverse.join(" ").say
