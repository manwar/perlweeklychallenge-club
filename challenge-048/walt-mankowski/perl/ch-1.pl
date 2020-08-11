#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(:5.30);
use experimental qw(signatures);

# TASK #1
# Survivor
# There are 50 people standing in a circle in position 1 to 50. The
# person standing at position 1 has a sword. He kills the next person
# i.e. standing at position 2 and pass on the sword to the immediate
# next i.e. person standing at position 3. Now the person at position 3
# does the same and it goes on until only one survives.

# Write a script to find out the survivor.

my @person = 1..50;
my $i = 0;
while (@person > 1) {
    my $j = ($i + 1) % @person;
    splice(@person, $j, 1);
    $i = ($i + 1) % @person;
}

say "The survivor is @person";
