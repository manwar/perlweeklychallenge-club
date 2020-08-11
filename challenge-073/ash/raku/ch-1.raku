#!/usr/bin/env raku

# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-073/

# Comments: https://andrewshitov.com/2020/08/10/raku-challenge-week-73/

my @a = 1, 5, 0, 2, 9, 3, 7, 6, 4, 8;
my $s = 3;

.min.say for @a.rotor($s => 1 - $s);

# Output:
# $ raku ch-1.raku 
# 0
# 0
# 0
# 2
# 3
# 3
# 4
# 4


# say @a.rotor(3 => -2);
## ((1 5 0) (5 0 2) (0 2 9) (2 9 3) (9 3 7) (3 7 6) (7 6 4) (6 4 8))
## Seq of Lists
