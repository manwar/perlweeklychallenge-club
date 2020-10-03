# # Smallest Positive Integer # #
# - You are given unsorted list of integers @N.
# - Write a script to find out the smallest positive number missing.
# #

use strict;
use warnings;
use feature 'say';

my @N = @ARGV || (5, 2, -2, 0);

# Filter out negative numbers and sort the resulting array
@N = sort (grep { $_ >= 0 } @N);

# if there are only negative numbers in the array, return 1, as that's the smallest possible positive number.
if (!@N) {
    say 1;    
    exit;
}

for my $i (0..$#N) {
    my $current_n = $N[$i];
    my $next_n = $N[$i+1] || 0;
    my $distance_between_ns = abs($current_n - $next_n);

    if ($distance_between_ns > 1) {
        say $current_n + 1;
        exit;
    }
}

# If there's no missing element, then return the last element of the array + 1; you could maybe say that's 
# technically the smallest positive number missing, as it's missing from the end of the array.
say $N[-1] + 1;

1;