#!/usr/bin/env perl

# The Weekly Challenge 270 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-270/
#
# Task 2 - Equalize Array
#

use strict;
use warnings;
use v5.28;
use List::Util qw (min max sum);
use Data::Dump qw(dump);

my @examples = (
    { ints => [ 4, 1 ], x =>3, y => 2}, 
    { ints => [ 2, 3, 3, 3, 5 ], x=> 2, y => 1},
);

sub equalize_array {
    my $params = shift;
    my $x = $params->{x};
    my $y = $params->{y};
    my @ints = @{$params->{ints}};
    my $max = max(@ints);
    my @to_process = grep { $_ < $max} @ints;
    my $length = scalar @to_process;
    my $cost = 0;

    while ($length > 0) {
        if ($length == 1) {
            $to_process[0]++;
            $cost += $x
        }else{
            $to_process[0]++;
            $to_process[1]++;
            $cost += $y
        }

        @to_process = grep { $_ < $max} @to_process;
        $length = scalar @to_process;
    }

    return $cost;
}

for my $elements (@examples) {
    my $ea = equalize_array $elements;

    say 'Input : @ints = ', dump($elements->{ints}), " x = $elements->{x} and y = $elements->{y}";
    say 'Output : ', $ea;
    say ' ';
}
