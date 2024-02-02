#!/usr/bin/env perl

# The Weekly Challenge 254 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-254/
#
# Task 2 - Reverse Vowels
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = ("Raku", "Perl", "Julia", "Uiua");

sub reverse_vowels {
    my $s = shift;
    my @letters = split(//, $s);
    my @vowels = reverse(grep { $_ =~ /[aeiou]/ix } @letters);

    for (my $i = 0; $i < @letters; $i++) {
        if ($letters[$i] =~ /[aeiou]/i) {
            $letters[$i] = shift @vowels;
        }
    }

    return join('', @letters);
}

for my $elements (@examples) {
    my $rv = reverse_vowels $elements;

    say 'Input : $s = ', dump($elements);
    say 'Output : ', $rv;
    say ' ';
}
