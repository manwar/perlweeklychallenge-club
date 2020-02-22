#!/usr/bin/env perl
# Steven Wilson
# Challenge 048 Task #1
# 22 Feb 2020

# Survivor

# There are 50 people standing in a circle in position 1 to 50. The
# person standing at position 1 has a sword. He kills the next person
# i.e. standing at position 2 and pass on the sword to the immediate
# next i.e. person standing at position 3. Now the person at position 3
# does the same and it goes on until only one survives.

# Write a script to find out the survivor.

use strict;
use warnings;
use feature qw/ say /;

my @circle   = 1 .. 50;
my $position = 1;

while ( scalar @circle > 1 ) {
    if ( $position > scalar @circle ) {
        $position = 0;
    }
    splice @circle, $position, 1;
    $position++;
}

say "Survivor is at position $circle[0]";

# Output:
# Survivor is at position 31
