#!/usr/bin/env perl6
use v6;

sub modcount($str) {
    return $str.split(/\s+/).[1..*-2].map(*.chars).sum;
}

say modcount(@*ARGS[0]);

# run as <script> "input string between quotes"
