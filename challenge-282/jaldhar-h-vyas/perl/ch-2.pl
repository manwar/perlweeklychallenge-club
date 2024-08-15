#!/usr/bin/perl
use v5.38;

my @chars = split //, lc shift;
my $current = shift @chars;
my $changes = 0;

for my $c (@chars) {
    if ($c ne $current) {
        $changes++;
        $current = $c;
    }
}

say $changes;
