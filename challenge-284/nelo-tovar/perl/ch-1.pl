#!/usr/bin/env perl

# The Weekly Challenge 284 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-284/
#
# Task 1 - Lucky Integer
#

use strict;
use warnings;
use v5.28;
use List::MoreUtils qw(frequency);
use Data::Dump qw(dump);

my @examples = (
    [ 2, 2, 3, 4 ],
    [ 1, 2, 2, 3, 3, 3 ],
    [ 1, 1, 1, 3 ],
);

sub lucky_integer {
    my $nums = shift;
    my %frequencies = frequency @$nums;
    my $lucky_integer = -1;

    foreach my $key (keys %frequencies) {
        $lucky_integer = $frequencies{$key} if ( ($frequencies{$key} == $key) and ($key > $lucky_integer ));
    }

    return $lucky_integer
}

for my $elements (@examples) {
    my $li = lucky_integer $elements;

    say 'Input : @ints = ', dump(@$elements);
    say 'Output : ', $li;
    say ' ';
}
