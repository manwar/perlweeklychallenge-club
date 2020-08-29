#!/usr/bin/env raku

# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-075/

# Comments: https://andrewshitov.com/2020/08/29/the-raku-challenge-week-75/

my @coins = 1, 2, 4;
my $sum = 6;

my @wallet;
@wallet.append: $_ xx ($sum div $_) for @coins;

# say @wallet;

.say for @wallet.combinations.unique(:as(*.Str)).grep({$sum == [+] $_});

# Output:
#
# $ raku ch-1.raku 
# (2 4)
# (1 1 4)
# (2 2 2)
# (1 1 2 2)
# (1 1 1 1 2)
# (1 1 1 1 1 1)
