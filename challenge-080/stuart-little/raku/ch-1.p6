#!/usr/bin/env perl6
use v6;

sub fstmiss(@a) {
    (1..*).grep({ ! @a.grep($_) }).first;
}

say fstmiss(@*ARGS);

# run as <script> num1 num2 ..
