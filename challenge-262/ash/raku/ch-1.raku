# Solution to Task 1 of The Weekly Challenge 262
# https://theweeklychallenge.org/blog/perl-weekly-challenge-262/#TASK1

# Test run:
# $ raku ch-1.raku
# 4
# 3
# 2

my @tests =
    (-3, 1, 2, -1, 3, -2, 4),
    (-1, -2, -3, 1),
    (1, 2);

for @tests -> @test {
    say max((@test.grep: * > 0).elems, (@test.grep: * < 0).elems);
}
