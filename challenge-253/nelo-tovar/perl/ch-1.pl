#!/usr/bin/env perl

# The Weekly Challenge 253 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-253/
#
# Task 1 - Split Strings
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples_words = (
    [ "one.two.three","four.five","six" ],
    [ '$perl$$', '$$raku$' ],
);
my @separators = ('.', '$');
         
sub split_string {
    my $separator = quotemeta(shift);
    my $words = shift;
    my @split;

    push(@split, grep {length $_} map({split(/$separator/, $_)} @$words));

    return \@split;
}

for my $elements (@examples_words) {
    my $separator = shift @separators;
    my $ss = split_string($separator, $elements);
  
    say 'Input     : @words = ', dump(@$elements);
    say '            $separator = ', $separator;
    say 'Output : ', dump(@$ss);
    say ' ';
}
