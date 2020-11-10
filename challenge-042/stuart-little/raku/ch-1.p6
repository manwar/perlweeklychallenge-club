#!/usr/bin/env perl6
use v6;

for (0..((@*ARGS) ?? (@*ARGS[0].Int) !! (50))).map({ "Decimal: $_ -- Octal: $_.base(8)" }) {.say}

# run as <script> <decimal number to go up to> or just <script> to default to the range 0..50
