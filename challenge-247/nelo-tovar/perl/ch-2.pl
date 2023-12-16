#!/usr/bin/env perl

# The Weekly Challenge 247 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-247/
#
# Task 2 - Most Frequent Letter Pair 
#

use strict;
use warnings;
use v5.28;
use Algorithm::Combinatorics qw(variations);
use Data::Dump qw(dump);

my @examples = (
    'abcdbca',
    'cdeabeabfcdfabgcd',
);

sub most_frequent_letter_pair {
    my $s = shift;
    my $length = length($s) - 1;
    my $pair = '';
    my $occurrence = 0;

    for (my $i = 0; $i < $length; $i++) {
        my $letters = substr($s, $i, 2); 

        my $count = () = ($s =~ m/$letters/g);
        if ($count > $occurrence) {
            $pair = $letters;
            $occurrence = $count;
        }elsif (( $count == $occurrence ) and ($letters lt $pair)){
            $pair = $letters;
        } 

    }
     
    return $pair;
}

for my $elements (@examples) {
    #    my $lot = largest_of_three $elements;
    my $pair = most_frequent_letter_pair $elements;

    say 'Input : $s = ', dump($elements);
    say 'Output : ', $pair;
    say ' ';
}
