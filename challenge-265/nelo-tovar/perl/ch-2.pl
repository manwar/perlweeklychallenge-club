#!/usr/bin/env perl

# The Weekly Challenge 265 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-265/
#
# Task 2 - Completing Word
#

use strict;
use warnings;
use v5.28;
use List::Util qw (min max);
use Algorithm::Combinatorics qw(combinations);
use Data::Dump qw(dump);

my @examples = (
    { str => 'aBc 11c', words => ['accbbb', 'abc', 'abbc'] },
    { str => 'Da2 abc', words => ['abcm', 'baacd', 'abaadc'] },
    { str => 'JB 007', words => ['jj', 'bb', 'bjb'] },
);

sub completing_word {
    my $string = lc(shift);
    my $words = shift;
    my %frequencies;
    my @candidates = ();

    foreach my $letter (split //, $string) {
       $frequencies{$letter}++ if ($letter =~ /[a-zA-Z]/) 
    }

    foreach my $word ($words->@*) {
       $word = lc($word); 
       my $is_candidate = 1;
       foreach my $k (keys %frequencies) {
          my @letters = $word =~ m/[$k]/g;

          $is_candidate = 0 if ($frequencies{$k} > scalar @letters);

          last if (!$is_candidate);
       }
       push @candidates, $word if $is_candidate;
    }

    return (sort({length($a) <=> length($b)} @candidates))[0];
}

for my $elements (@examples) {
    my $string = $elements->{str};
    my $words = $elements->{words}; 
    my $cw = completing_word $string, $words;

    say "Input : \$str = '$string'";
    say '      : @str = ', dump(@$words);
    say 'Output : ', $cw;
    say ' ';
}
