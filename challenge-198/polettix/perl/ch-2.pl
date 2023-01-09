#!/usr/bin/env perl
use ntheory 'prime_count';
print prime_count(($ARGV[0] // 10) - 1), "\n";
