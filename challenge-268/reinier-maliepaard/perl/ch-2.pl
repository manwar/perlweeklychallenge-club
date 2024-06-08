#!/usr/bin/perl
use strict;
use warnings;

use List::MoreUtils qw(natatime);

sub number_game {

    my @ints = sort (@_);
    my @new_arr = ();

    # https://metacpan.org/pod/List::MoreUtils -> natatime
    # natatime creates an array iterator, for looping over an array in chunks of $n items at a time.
    # in our case $n = 2
    my $it = (natatime 2, @ints);
    while (my @vals = reverse( $it->() )) {
        push(@new_arr, @vals);
    }
    print "(", join(", ", @new_arr), ")\n";

}

# TESTS

my @ints;

# Example 1
@ints = (2, 5, 3, 4);
number_game(@ints); # Output: (3, 2, 5, 4)

# Example 2
@ints = (9, 4, 1, 3, 6, 4, 6, 1);
number_game(@ints); # Output: (1, 1, 4, 3, 6, 4, 9, 6)

# Example 3
@ints = (1, 2, 2, 3);
number_game(@ints); # Output: (2, 1, 3, 2)
