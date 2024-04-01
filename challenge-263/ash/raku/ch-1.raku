# Solution to Task 1 of The Weekly Challenge 263
# https://theweeklychallenge.org/blog/perl-weekly-challenge-263/#TASK1

# Test run:
# $ raku ch-1.raku
# (1 2)
# ()
# (4)

my @tests =
    ((1, 5, 3, 2, 4, 2), 2),
    ((1, 2, 4, 3, 5),    6),
    ((5, 3, 2, 4, 2, 1), 4);

for @tests -> @test {
    say solve(@test[0], @test[1]);
}

sub solve(@data, $value) {
    my @sorted = @data.sort;
    return @sorted.grep($value, :k);
}
