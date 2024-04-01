# Solution to the Task 1 of the Weekly Challenge #258
# https://theweeklychallenge.org/blog/perl-weekly-challenge-258/#TASK1

# Test run:
# $ raku ch-1.raku 
# 3

my @ints = 10, 1, 111, 24, 1000; # 3
# my @ints = 111, 1, 11111; # 0
# my @ints = 2, 8, 1024, 256; # 1

say (
        @ints.grep(
            *.chars %% 2
        )
        .elems
    );
