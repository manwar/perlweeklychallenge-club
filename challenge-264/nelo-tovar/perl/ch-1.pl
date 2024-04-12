#!/usr/bin/env perl

# The Weekly Challenge 264 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-264/
#
# Task 1 - Greatest English Letter
#

use strict;
use warnings;
use v5.28;
use Data::Dump qw(dump);

my @examples = (
    'PeRlwEeKLy',
    'ChaLlenge',
    'The',
);

sub greatest_english_letter {
    my $str = shift;
    my @letters = split '', $str;
    my $greatest = '';

    foreach my $letter (@letters) {
        next if ($letter ne uc($letter));

        my $lower = lc($letter);
        $greatest = $letter if ($greatest lt $letter and $str =~ /$lower/);
    }

    return $greatest;

}

for my $elements (@examples) {
    my $gel = greatest_english_letter $elements;

    say 'Input : @str = ', $elements;
    say 'Output : ', $gel;
    say ' ';
}
