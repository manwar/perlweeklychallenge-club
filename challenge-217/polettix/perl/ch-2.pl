#!/usr/bin/env perl
print join('', sort { ($b . $a) <=> ($a . $b) } @ARGV), "\n";
