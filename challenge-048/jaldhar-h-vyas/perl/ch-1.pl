#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

my @people = (0 .. 49);

my $remaining = scalar @people;
my $next = 0;
my $victim = 1;

while ($remaining > 1) {
    $people[$victim] = undef;
    $remaining--;
    do {
        $next = ($next + 1) % 50;
    } until defined $people[$next];

    $victim = $next;
    do {
        $victim = ($victim + 1) % 50;
    } until defined $people[$victim];
}

say +(grep { defined $_; } @people)[0] + 1;
