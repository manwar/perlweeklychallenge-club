# Task 2 of the Weekly Challenge 322
# https://theweeklychallenge.org/blog/perl-weekly-challenge-322/#TASK2

say rank 55, 22, 44, 33; # (4 1 3 2)
say rank 10, 10, 10;     # (1 1 1)
say rank 5, 1, 1, 4, 3;  # (4, 1, 1, 3, 2)

sub rank(*@ints) {
    my %rank = @ints.sort.unique.kv.reverse;

    return @ints.map({%rank{$_} + 1});
}
