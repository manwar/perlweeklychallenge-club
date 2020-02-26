#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
  qw{ experimental::postderef experimental::smartmatch experimental::signatures };

# There are 500 rooms in a hotel with 500 employees having keys to all the rooms.
# The first employee opened main entrance door of all the rooms.
# The second employee then closed the doors of room numbers 2,4,6,8,10 and so on to 500.
# The third employee then closed the door if it was opened or opened the door
#     if it was closed of rooms 3,6,9,12,15 and so on to 500.
# Similarly the fourth employee did the same as the third but only room numbers
#     4,8,12,16 and so on to 500.
# This goes on until all employees has had a turn.
# Write a script to find out all the rooms still open at the end.

# for once, indexing on 1 not zero would be nice. But we can
# ignore door zero. 


# first employee opens everything, then the second employee closes
# half, so it's just a toggle, or x = !x

# and we use grep to only get every nth index into the array,
# and modulus equalling zero to indicate which indexes go through

my @doors = map { 1 } 0 .. 500;
for my $e ( 2 .. 500 ) {
    map { $doors[$_] = !$doors[$_] }
      grep { 0 == $_ % $e } 1 .. 500;
}
say join ' ', grep { $doors[$_] } 1 .. 500;
