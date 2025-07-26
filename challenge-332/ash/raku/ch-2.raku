# Task 2 of the Weekly Challenge 332
# https://theweeklychallenge.org/blog/perl-weekly-challenge-332/#TASK2

say are-all-letters-odd('weekly');    # False
say are-all-letters-odd('perl');      # True
say are-all-letters-odd('challenge'); # False

sub are-all-letters-odd($str) {
    return !($str.comb.Bag.first: *.value %% 2);
}
