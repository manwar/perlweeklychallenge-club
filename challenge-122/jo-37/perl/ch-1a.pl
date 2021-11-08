#!/usr/bin/perl

use v5.16;
use warnings;
$| = 1;

# Provide a stream of numbers.

my $n;
while (($n += 10) < ($ARGV[0] // 100)) {
    say $n;
    sleep 1;
}
