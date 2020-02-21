use strict;
use warnings;

my @position = (1..50);

until (@position == 1) {
    splice @position, 1, 1;
    push @position, shift @position;
}

print "Survivor started in position @position";
