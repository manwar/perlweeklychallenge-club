#!/usr/bin/env perl6
use v6;

# run <script> <number>

say "Initial number in base two: ", my $binNr = sprintf("0%b", @*ARGS[0]);
say "Next number in base two: ", my $next = ((@*ARGS[0].Int % 2) ?? (S!01(1*)$!10$0! with $binNr) !! (S!01(1*)(0*)$!10$1$0! with $binNr));
say "Next number in base ten: ", parse-base($next,2);


