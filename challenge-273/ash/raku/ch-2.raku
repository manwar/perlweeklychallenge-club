# Solution to the Task 2 of the Weekly Challenge 273
# https://theweeklychallenge.org/blog/perl-weekly-challenge-273/#TASK2

# Test run:
# $ raku ch-2.raku
# true
# false
# false
# true

my @tests = < aabb abab aaa bbb >;

for @tests -> $test {
    say lc ?($test ~~ / bb /);
}
