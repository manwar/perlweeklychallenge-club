#!/usr/bin/env perl

# The Weekly Challenge 250 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-250/
#
# Task 2 - Alphanumeric String Value
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    [ "perl", "2", "000", "python", "r4ku" ],
    [ "001", "1", "000", "0001" ],
);

sub alphanumeric_string_value {
    my $alphanumstr = shift;
    my $max = 0;

    foreach my $x (@$alphanumstr) {
        my $value = ($x =~ /^\d+$/ ? $x + 0 : length $x);

        $max = $value if ( $value > $max)
    }

    return $max;
}

for my $elements (@examples) {
    my $asv = alphanumeric_string_value $elements;

    say 'Input : @alphanumstr = ', dump(@$elements);
    say 'Output : ', $asv;
    say ' ';
}
