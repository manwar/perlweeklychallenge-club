#!/usr/bin/env perl6
use v6;

for (2019..2100).map({ $_ => Date.new($_,12,25).day-of-week }).grep(*.value==7).map("25 Dec " ~ *.key) {.say}

# run as <script>
