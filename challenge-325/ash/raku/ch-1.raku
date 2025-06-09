
# Task 1 of the Weekly Challenge 325
# https://theweeklychallenge.org/blog/perl-weekly-challenge-325

say solve 0, 1, 1, 0, 1, 1, 1; # 3
say solve 0, 0, 0, 0;          # 0
say solve 1, 0, 1, 0, 1, 1;    # 2


sub solve(*@data) {
    (
        (
            @data.join ~~ m:g/(1+)/
        )>>.chars
        || 0
    ).max
}
