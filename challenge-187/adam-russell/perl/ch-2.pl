use v5.36;
use strict;
use warnings;
##
# You are given a list of positive numbers, @n, having at least 3 numbers.
# Write a script to find the triplets (a, b, c) from the given list that satisfies 
# the following rules.
#    a + b > c
#    b + c > a
#    a + c > b
#    a + b + c is maximum.
##
use Hash::MultiKey;
use Math::Combinatorics;

sub magical_triples{
    my(@numbers) = @_;
    my %triple_sum;
    tie %triple_sum, q/Hash::MultiKey/;
    my $combinations = Math::Combinatorics->new(count => 3, data => [@numbers]);
    my($s, $t, $u);
    while(my @combination = $combinations->next_combination()){
        my($s, $t, $u) = @combination;
        my $sum;
        $sum = $s + $t + $u if $s + $t > $u && $t + $u > $s && $s + $u > $t;
        $triple_sum{[$s, $t, $u]} = $sum if $sum;
    }
    my @triples_sorted = sort {$triple_sum{$b} <=> $triple_sum{$a}} keys %triple_sum; 
    return ($triples_sorted[0]->[0], $triples_sorted[0]->[1], $triples_sorted[0]->[2]) if @triples_sorted;
    return ();
}

MAIN:{
    say "(" . join(", ", magical_triples(1, 2, 3, 2)) . ")";
    say "(" . join(", ", magical_triples(1, 3, 2)) . ")";
    say "(" . join(", ", magical_triples(1, 1, 2, 3)) . ")";
    say "(" . join(", ", magical_triples(2, 4, 3)) . ")";
}