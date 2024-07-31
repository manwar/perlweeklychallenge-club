#!/usr/bin/env perl

# The Weekly Challenge 279 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-279/
#
# Task 2 - Split String
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = ('perl', 'book', 'good morning');

sub split_string {
    my $word = shift;
    $_ = lc $word;
    my $count = tr/aeiou//; 
    my $return = 'false';

    return $count % 2 == 0 ? 'true': 'false'; 

}

for my $elements (@examples) {
    my $ss = split_string $elements;

    say 'Input : str = ', $elements;
    say 'Output : ', $ss;
    say ' ';
}
