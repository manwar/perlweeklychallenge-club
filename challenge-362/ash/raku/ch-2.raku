# Task 2 of the Weekly Challenge 362
# https://theweeklychallenge.org/blog/perl-weekly-challenge-362/#TASK2

use Lingua::EN::Numbers;

say sort-alpha 6, 7, 8, 9, 10;    # (8 9 7 6 10)
say sort-alpha -3, 0, 1000, 99;   # (-3 99 1000 0)
say sort-alpha 1, 2, 3, 4, 5;     # (5 4 1 3 2)
say sort-alpha 0, -1, -2, -3, -4; # (-4 -1 -3 -2 0)
say sort-alpha 100, 101, 102;     # (100 101 102)

sub sort-alpha(*@data) {
    @data.map({
        cardinal($^a), $a
    }).sort.map({$^a[1]})
}
