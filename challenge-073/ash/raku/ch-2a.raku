#!/usr/bin/env raku

# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-073/

# Comments: https://andrewshitov.com/2020/08/10/raku-challenge-week-73/

my @a = 7, 8, 3, 12, 10;

my $min = Inf;
for @a -> $v {
    say $v < $min ?? 0 !! $min;
    $min = $v if $v < $min;
}

# Output: 
# $ raku ch-2a.raku 
# 0
# 7
# 0
# 3
# 3
