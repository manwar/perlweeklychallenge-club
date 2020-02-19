#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my $peons = 50;
my @peon;
for my $i (1..$peons) {
    push @peon, $i;
}

while (scalar @peon > 1) {
    say "$peon[0] killed $peon[1]";
    push @peon, shift @peon;
    shift @peon;
}

say "@peon wins";
