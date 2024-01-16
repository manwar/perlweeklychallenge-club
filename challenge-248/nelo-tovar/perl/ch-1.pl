#!/usr/bin/env perl

# The Weekly Challenge 248 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-248/
#
# Task 1 - Shortest Distance
#

use strict;
use warnings;
use v5.28;
use List::MoreUtils qw(indexes minmax);
use List::Util qw(min);
use Data::Dump qw(dump);

my @examples_str = (
    "loveleetcode",
    "aaab",
);

my @examples_char = (
    'e',
    'b',
);

sub shortest_distance {
    my @str = split //, shift;
    my $char = shift;
    my @indexes = indexes { $_ eq $char } @str;
    my @distances = ();

    @distances = map {my $index = $_;min(map {abs($_ - $index)} @indexes)} 0 .. $#str;

    return \@distances;
}

#for my $elements (@examples) {
my $length = scalar @examples_str;
for (my $i = 0; $i < $length; $i++) {
    
    my $sd = shortest_distance $examples_str[$i], $examples_char[$i];

    say "Input : str = \"$examples_str[$i]\", char = \"$examples_char[$i]\"";
    say 'Output : ', dump(@$sd);
    say ' ';
}
