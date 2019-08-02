#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

# Pythagoras Pie Puzzle, proposed by Jo Christian Oterhals.
#
# At a party a pie is to be shared by 100 guest.
# The first guest gets 1% of the pie, the second guest gets 2% of the
# remaining pie, the third gets 3% of the remaining pie, the fourth gets
# 4% and so on.
#
# Write a script that figures out which guest gets the largest piece of pie.

my $max_id    = 0;
my $max_slice = 0;
my $pie       = 100;

for my $id ( 1 .. 100 ) {

    # $id is also % of the pie taken, so the last gets all that's left
    # which is microscopic.
    #   id / 100 == slice / pie
    # so
    #   id * pie / 100 = slice
    # and then be sure to remove the slice from the pie.

    my $slice = $pie * $id / 100;
    $pie -= $slice;

    # we want the largest slice, so we start with a zero-slice and
    # go on from there. I know from lookig at the results that as soon
    # as we start seeing the slice size decreasing, we can just stop.
    # but I don't.

    if ( $slice > $max_slice ) {
        $max_slice = $slice;
        $max_id    = $id;
    }
}

say <<"END";
ID:     $max_id
Slice:  $max_slice
END

__DATA__

$ ./ch-1.pl 
ID:     10
Slice:  6.28156509555295

