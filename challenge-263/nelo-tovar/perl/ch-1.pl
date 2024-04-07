#!/usr/bin/env perl

# The Weekly Challenge 263 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-263/
#
# Task 1 - Target Index
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    {k => 2, ints => [ 1, 5, 3, 2, 4, 2 ]},
    {k => 6, ints => [ 1, 2, 4, 3, 5 ]},
    {k => 4, ints => [ 5, 3, 2, 4, 2, 1 ]},
);

sub target_index {
    my $params = shift;
    my $k = $params->{k};
    my @nums = sort $params->{ints}->@*;
    my $len = scalar @nums;
    my @indexes;

    for (my $i = 0; $i < $len; $i++) {
        push(@indexes, $i) if ($nums[$i] eq $k) 
    }
    
    return \@indexes;
}

for my $elements (@examples) {
    my $ti = target_index $elements;

    say 'Input : @ints = ', dump($elements->{ints}), ", K = $elements->{k}";
    say 'Output : ', dump(@$ti);
    say ' ';
}
