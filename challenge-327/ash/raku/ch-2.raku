# Task 2 of the Weekly Challenge 327
# https://theweeklychallenge.org/blog/perl-weekly-challenge-327/#TASK2

say mad(4, 1, 2, 3);      # ((4 3) (1 2) (2 3))
say mad(1, 3, 7, 11, 15); # ((1 3))
say mad(1, 5, 3, 8);      # ((1 3) (5 3))

sub mad(*@data) {
    my @pairs = @data.combinations(2);
    my $min_diff = min(@pairs.map: {abs(.[0] - .[1])});

    return @pairs.grep: {abs(.[0] - .[1]) == $min_diff};
}
