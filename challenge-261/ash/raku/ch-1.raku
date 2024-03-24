# Solution to the Task 1 of The Weekly Challenge 261
# https://theweeklychallenge.org/blog/perl-weekly-challenge-261/#TASK1

# Test run:
# $ raku ch-1.raku
# 36
# 9
# 0

my @tests = 
    (1, 2, 3, 45),
    (1, 12, 3),
    (1, 2, 3, 4);

for @tests -> @test {
    my $sum = [+] @test;
    my $dig = [+]((@test.map: *.comb).flat);
    say ($dig - $sum).abs;
}
