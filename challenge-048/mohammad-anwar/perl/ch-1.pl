#!/usr/bin/perl

use strict;
use warnings;

my @people = map { 'p'.$_ } (1 ..50);
while (scalar(@people) > 1) {
    my $sword = shift @people;
    shift @people;
    push @people, $sword;
}

($people[0] =~ /p(\d+)/) && print "Survivor is at position $1\n";
