# Solution to the Task 2 of the Weekly Challenge 326
# https://theweeklychallenge.org/blog/perl-weekly-challenge-326/#TASK2

say decompress(1, 3, 2, 4); # 3 4 4
say decompress(1, 1, 2, 2); # 1 2 2
say decompress(3, 1, 3, 2); # 1 1 1 2 2 2

sub decompress(*@list) {
    (gather for @list -> $repetitions, $value {
        take $value xx $repetitions;
    }).flat
}
