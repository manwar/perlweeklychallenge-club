#!/usr/bin/env perl

# Challenge 048
#
# TASK #1
# Survivor
# There are 50 people standing in a circle in position 1 to 50. The person
# standing at position 1 has a sword. He kills the next person i.e. standing at
# position 2 and pass on the sword to the immediate next i.e. person standing at
# position 3. Now the person at position 3 does the same and it goes on until
# only one survives.
#
# Write a script to find out the survivor.

use Modern::Perl;

my @surv = (1..50);
my $p = 0;
while (@surv > 1) {
    # kill next
    if ($p >= $#surv) {
        @surv = @surv[1..$#surv];
    }
    else {
        splice(@surv, $p+1, 1);
    }
    # advance sword
    $p++;
    $p = 0 if $p >= @surv;
}
say @surv;
