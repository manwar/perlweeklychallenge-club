#!/usr/bin/env raku

# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-078/

# Comments: https://andrewshitov.com/2020/09/14/the-weekly-challenge-078/

my @a = 9, 10, 7, 5, 6, 1;

for @a.kv -> $i, $v {
    say $v if $v > all(@a[$i^..*]);
}
