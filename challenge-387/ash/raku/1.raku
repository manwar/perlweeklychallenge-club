# Task 1 of the Weekly Challenge 387
# https://theweeklychallenge.org/blog/perl-weekly-challenge-387/#TASK1

# Output:
#
# 11000
# 11100
# 111000
# 10000

my @cases = "00011", "01011", "010101", "00001";

sub replace($s is copy) {
    $s ~~ s:g/01/10/ while $s ~~ /01/;
    $s;
}

for @cases -> $s {
    say replace($s);
}
