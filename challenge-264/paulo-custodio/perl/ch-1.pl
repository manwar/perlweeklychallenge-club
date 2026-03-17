#!/usr/bin/env perl

# Perl Weekly Challenge 264 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-264/

use Modern::Perl;

say greatest_letter(shift // '');

sub greatest_letter {
    my($word) = @_;
    for my $upper (reverse 'A' .. 'Z') {
        my $lower = lc($upper);
        return $upper if $word =~ /$upper/ && $word =~ /$lower/;
    }
    return "''";
}
