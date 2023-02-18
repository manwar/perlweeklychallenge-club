#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    [ 1, 2, 2, 3 ],
    [ 1, 3, 2 ],
    [ 6, 5, 5, 4 ],
    [ map { 7 } 1 .. 6 ],
);

for my $e (@examples) {
    my $list = join ',', $e->@*;
    my $out  = monotonic( $e->@* );
    say <<"END";
    Input:  \@array = ($list)
    Output: $out
END
}

# Monotone increasing: for i <= j , nums[i] <= nums[j]
# Monotone decreasing: for i <= j , nums[i] >= nums[j]

# first pass I wrote, I made it so that i was less than j by 1,
# not all indexes less than j. (In my code, I reverse i and j
# because I always use i for index of the main loop)

# So, we test to see if there's been both increasing and decreasing.
# The "spaceship" operator is most often used in sorting numeric
# values, which will give us a 1 if the first value is larger
# than the second, -1 if the opposite, and 0 if they're the same.
# We watch for increasing and decreasing, and if we get values
# for both, we return 0. At the end, if we don't find non-monotonic
# values, we return 1.

sub monotonic (@array) {
    my $increasing = 0;
    my $decreasing = 0;
    for my $i ( 1 .. -1 + scalar @array ) {
        for my $j ( 0 .. -1 + $i ) {
            my $k = $array[$j] <=> $array[$i];
            $decreasing++ if $k == -1;
            $increasing++ if $k == 1;
            return 0      if $decreasing && $increasing;
        }
    }
    return 1;
}
