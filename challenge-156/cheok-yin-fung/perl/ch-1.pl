#!/usr/bin/perl
# The Weekly Challenge 156
# Task 1 Pernicious Number
# Usage: 
# ch-1.pl [$N, for an output with the first $N pernicious number]
use v5.22.0;
use warnings;
use Math::Prime::Util qw /next_prime/;
use Algorithm::Combinatorics qw/combinations/;

my $N = $ARGV[0] || 10;

my $list_size = $N;
my $ub = 3*$N;

my @pern_num = ();

for my $k (2..$ub) {
    my $prime = 2;
    while ($prime <= $k) {
        my @length_k_weight_p_num = ();
        my $iter = combinations([1..$k-1], $prime-1);
        while (my $c = $iter->next) {
            my @ch = ((1), (0) x ($k-1));
            $ch[$_] = 1 for @{$c};
            my $new_pern_num = oct("0b".(join "", @ch));
            push @length_k_weight_p_num, $new_pern_num;
        }
        push @pern_num, @length_k_weight_p_num;
        $prime = next_prime($prime);
    }
    last if scalar @pern_num >= $N;
}


@pern_num = sort {$a<=>$b} @pern_num;
say join ", ", @pern_num[0..$N-1]; 


