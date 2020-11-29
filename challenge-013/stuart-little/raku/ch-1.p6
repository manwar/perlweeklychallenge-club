#!/usr/bin/env perl6
use v6;

for (1..12).map({ ((my $date=Date.new(@*ARGS[0],$_,1))..$date.last-date-in-month).reverse.first(*.day-of-week == 5) }) {.say}

# run as <script> <year>
