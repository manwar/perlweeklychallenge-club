#!/usr/bin/env perl

# Perl Weekly Challenge 216 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-216/

use Modern::Perl;

sub has_every_letter {
    my($word, $reg) = @_;
    $reg =~ s/\s+//g;
    $reg =~ s/0/o/g;
    $reg =~ s/\d+//g;
    for my $letter (split //, $word) {
        $reg =~ s/$letter//gi;
    }
    return $reg eq '';
}

my($reg, @words) = @ARGV;
say join ", ", grep {has_every_letter($_, $reg)} @words;
