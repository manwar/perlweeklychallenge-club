# Task 2 of the Weekly Challenge 351
# https://theweeklychallenge.org/blog/perl-weekly-challenge-351/#TASK2

say is-progression 1, 3, 5, 7, 9;     # True
say is-progression 9, 1, 7, 5, 3;     # True
say is-progression 1, 2, 4, 8, 16;    # False
say is-progression 5, -1, 3, 1, -3;   # True
say is-progression 1.5, 3, 0, 4.5, 6; # True

sub is-progression(*@data) {
    [==] @data.sort.rotor(2 => -1).map: {.[1] - .[0]}
}
