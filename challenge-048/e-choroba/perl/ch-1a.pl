#! /usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my @people = 1 .. 50;
my $sword = 0;
while (@people > 1) {
    $sword = (1 + $sword) % @people;
    splice @people, $sword, 1;
    $sword %= @people;
}
say $people[0];
