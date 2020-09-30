# # Count Candies # #
# - You are given rankings of @N candidates.
# - Write a script to find out the total candies needed for all candidates. 
#   You are asked to follow the rules below:
#     a) You must given at least one candy to each candidate.
#     b) Candidates with higher rankings get more candies than their immediate neighbors on either side.
# #

use strict;
use warnings;
use feature 'say';

my @N = @ARGV || (1, 2, 2);

my $total_candies = 0;

# Applying rule #a, each candidate must get at least one candy
$total_candies += scalar @N;

# Applying rule #b, each candidate that has a higher ranking than its neighbour(s)
# gets an additional piece of candy for each lower-ranking neighbour
for my $i (0..$#N) {
    my $current_candidate_rank = $N[$i];
    my $next_candidate_rank = $N[$i+1];
    my $previous_candidate_rank = $N[$i-1];

    if ($next_candidate_rank && $current_candidate_rank > $next_candidate_rank) {
        $total_candies++;
    }
    if ($previous_candidate_rank && $current_candidate_rank > $previous_candidate_rank) {
        $total_candies++;
    }
}

say $total_candies;

1;