#!/usr/bin/env perl

# The Weekly Challenge 262 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-262/
#
# Task 2 - Count Equal Divisible
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    { k => 2, ints => [3,1,2,2,2,1,3] },
    { k => 1, ints => [1,2,3] },
);

sub count_equal_divisible {
    my $input = shift;
    my $ints = $input->{ints};
    my $length = scalar @$ints; 
    my $count = 0;

    for (my $i = 0; $i <= $length - 1; $i++) {
        for (my $j = $i + 1; $j < $length; $j++) {
            $count++ if (($ints->[$i] eq $ints->[$j]) and (($i * $j % $input->{k}) eq 0) );
        }
    }
     
    return $count;
}

for my $elements (@examples) {
    my $ced = count_equal_divisible $elements;

    say 'Input : @ints = ', dump($elements->{ints}), ' and K = ', $elements->{k};
    say 'Output : ', $ced;
    say ' ';
}
