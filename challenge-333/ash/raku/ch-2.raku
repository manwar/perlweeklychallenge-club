# Task 2 of the Weekly Challenge 333
# https://theweeklychallenge.org/blog/perl-weekly-challenge-333/#TASK2

say duplicate-zeros(1, 0, 2, 3, 0, 4, 5, 0); # (1 0 0 2 3 0 0 4)
say duplicate-zeros(1, 2, 3); # (1 2 3)
say duplicate-zeros(1, 2, 3, 0); # (1 2 3 0)
say duplicate-zeros(0, 0, 1, 2); # (0 0 0 0)
say duplicate-zeros(1, 2, 0, 3, 4); # (1, 2, 0, 0, 3)

sub duplicate-zeros(*@data) {
    my $len = @data.elems;

    my @out;
    $_ ?? @out.push($_) !! @out.push(0, 0) for @data;

    return @out[^$len];
}
