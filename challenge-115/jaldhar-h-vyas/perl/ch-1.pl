#!/usr/bin/perl
use 5.020;
use warnings;

my (%first, %last);

for my $arg (@ARGV) {
    $first{substr($arg, 0, 1)} = 1;
    $last{substr($arg, -1, 1)} = 1;
}

for my $key (keys %first) {
    unless (exists $last{$key}) {
        say 0;
        exit;
    }
}
say 1;

