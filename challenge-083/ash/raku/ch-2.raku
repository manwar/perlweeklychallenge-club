#!/usr/bin/env raku
#
# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-083/

my @a = 12, 2, 100;
# Number of sign flips: 2; min sum: 86

# my @a = 12, 2, 10;
# Number of sign flips: 1; min sum: 0

# my @a = 3, 10, 8;
# Number of sign flips: 1; min sum: 1

my $min_sum = Inf;
my $min_flips = Inf;
my $min_comb = '';

my $fmt = '%0' ~ @a.elems ~ 'b';

for ^ 2**@a -> $n {
    my @bits = $n.fmt($fmt).comb;

    my $sum = [+] @bits>>.subst(0, -1) Z* @a;
    next if $sum < 0;
    
    if $sum < $min_sum {
        $min_sum = $sum;
        my $flips = @bits.grep(0).elems;
        $min_flips = $flips if $flips < $min_flips;
    }
}

say "Number of sign flips: $min_flips; min sum: $min_sum";
