#!/usr/bin/perl

use strict;
use warnings;

my @people = (1 ..50);
while (scalar(@people) > 1) {
    my $sword = shift @people;
    shift @people;
    push @people, $sword;
}

print "Survivor is at position $people[0]\n";
