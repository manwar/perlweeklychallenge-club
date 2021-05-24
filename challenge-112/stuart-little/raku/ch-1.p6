#!/usr/bin/env perl6
use v6;

# run <script> <path>

IO::Spec::Unix.canonpath(@*ARGS[0], :parent).say;
