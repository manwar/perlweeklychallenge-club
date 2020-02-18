#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental::postderef experimental::signatures };

my @x = 1 .. 50;

# the way it works is the first person kills the second person
# and hands the sword to the third person, 

# There could be a lot of DIRE inner-array mess in this, but no. 
# There are two actions

# passing the sword -> unshifting from the array and pushing at the end
# killing the next  -> unshifting from the array

my $i = 0;
while ( scalar @x > 1 ) {
    push @x, shift @x; # move killer to the end
    shift @x; # killer gets next
}
say join ',', @x;

__DATA__


Survivor
There are 50 people standing in a circle in position 1 to 50. 
The person standing at position 1 has a sword. He kills the next 
person i.e. standing at position 2 and pass on the sword to the 
immediate next i.e. person standing at position 3. Now the person 
at position 3 does the same and it goes on until only one survives.

Write a script to find out the survivor.

