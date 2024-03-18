# Solution to the Task 2 of The Weekly Challenge 261
# https://theweeklychallenge.org/blog/perl-weekly-challenge-261/#TASK2

# Test run:
# $ raku ch-2.raku
# 24
# 8
# 2

my @tests = 
    ((5,3,6,1,12), 3),
    ((1,2,4,3), 1),
    ((5,6,7), 2);

for @tests -> (@ints, $start is copy) {
    my $ints = @ints.Bag;

    $start *= 2 while $ints{$start};
    say $start;
}
