#!/usr/bin/perl
# test: perl ch-2.pl
use strict;
use warnings;
use feature qw /say/;

my @doors;
$doors[$_] = 0 for (0 .. 500);

for my $employee (1 .. 500) {
    for my $door ($employee .. 500 ) {
        next unless $door % $employee == 0;
        $doors[$door] = ($doors[$door]) ? 0 : 1;
    }
}

for my $i (1 .. 500) {
    say "Door: " . $i . " is open."
        if ($doors[$i]);
}
