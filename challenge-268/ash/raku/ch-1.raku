# Task 1 of The Weekly Challenge 268
# https://theweeklychallenge.org/blog/perl-weekly-challenge-268/#TASK1

# Test run:
# $ raku ch-1.raku
# 2
# 3
# 3
# No such number

my @tests =
    ([3, 7, 5], [9, 5, 7]),
    ([1, 2, 1], [5, 4, 4]),
    ([2], [5]),
    
    ([3, 7, 5], [9, 5, 17]);

for @tests -> (@a is copy, @b is copy) {
    @a .= sort;
    @b .= sort;

    my $diff = @b[0] - @a[0];
    if @a >>+>> $diff eqv @b {
        say $diff;
    }
    else {
        say "No such number";
    }
}
