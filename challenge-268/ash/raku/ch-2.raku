# Task 2 of The Weekly Challenge 268
# https://theweeklychallenge.org/blog/perl-weekly-challenge-268/#TASK2

# Test run:
# $ raku ch-2.raku
# [3 2 5 4]
# [1 1 4 3 6 4 9 6]
# [2 1 3 2]

my @tests =
    (2, 5, 3, 4),
    (9, 4, 1, 3, 6, 4, 6, 1),
    (1, 2, 2, 3);

for @tests -> @test {
    my @out;
    for @test.sort -> $a, $b {
        if $a > $b {
            @out.push($a, $b);
        }
        else {
            @out.push($b, $a);
        }
    }

    say @out;
}
