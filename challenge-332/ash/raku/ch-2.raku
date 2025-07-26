# Task 2 of the Weekly Challenge 332
# https://theweeklychallenge.org/blog/perl-weekly-challenge-332/#TASK2

say are-oll-letters-odd('weekly');    # False
say are-oll-letters-odd('perl');      # True
say are-oll-letters-odd('challenge'); # False

sub are-oll-letters-odd($str) {
    return !($str.comb.Bag.first: *.value %% 2);
}
