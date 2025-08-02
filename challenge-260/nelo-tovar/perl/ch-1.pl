#!/usr/bin/env perl

# The Weekly Challenge 260 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-260/
#
# Task 1 - Unique Occurrences
#

use strict;
use warnings;
use v5.28;
use List::Util qw/uniqint/;
use Data::Dump qw(dump);

my @examples = (
    [ 1,2,2,1,1,3 ],
    [ 1, 2, 3 ],
    [ -2,0,1,-2,1,1,0,1,-2,9 ],
);

sub unique_occurrences {
    my $nums = shift;
    my %counter;

    $counter{$_}++ foreach (@$nums);
    my $frequencies = values %counter;
    my $unique = uniqint(values %counter);

    return $frequencies eq $unique ? 1 : 0;
}

for my $elements (@examples) {
    my $uo = unique_occurrences $elements;

    say 'Input : @ints = ', dump(@$elements);
    say 'Output : ', $uo;
    say ' ';
}
