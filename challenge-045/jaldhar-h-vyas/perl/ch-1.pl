#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

my $input = lc join q{ }, @ARGV;
$input =~ s/\s+//gmx;
my @rows;
while (length $input) {
    push @rows, substr $input, 0, 8, q{};
}

my @cols;
for my $row (@rows) {
    my @chars = split //, $row;
    for my $i (0 .. 7) {
        if ($chars[$i]) {
            $cols[$i] .= $chars[$i];
        }
    }
}

say join q{ }, @cols;

