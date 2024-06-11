# Solution to the Task 1 of the Weekly Challenge 273
# https://theweeklychallenge.org/blog/perl-weekly-challenge-273/#TASK1

# Test run:
# $ raku ch-1.raku
# 25
# 50
# 0
# 67
# 22
# 13

my @tests =
    perl => 'e',
    java => 'a',
    python => 'm',
    ada => 'a',
    ballerina => 'l',
    analitik => 'k';

for @tests -> $pair {
    say (100 * $pair.key.comb($pair.value) / $pair.key.comb).round;
    # say (100 * $pair.key.comb($pair.value).elems / $pair.key.comb.elems).round;
}
