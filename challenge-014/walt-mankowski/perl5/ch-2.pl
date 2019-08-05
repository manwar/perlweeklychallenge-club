#!/usr/bin/env perl

# Perl Weekly Challenge 014-2
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-014/
#
# Using only the official postal (2-letter) abbreviations for the 50
# U.S. states, write a script to find the longest English word you can
# spell?

use strict;
use warnings;
use feature qw(:5.30);
use experimental qw(signatures);
use autodie;

# create map of state abbreviations
my %abbrevs = map {$_ => 1} qw(al ak az ar ca co ct de fl ga
                               hi id il in ia ks ky la me md
                               ma mi mn ms mo mt ne nv nh nj
                               nm ny nc nd oh ok or pa ri sc
                               sd tn tx ut vt va wa wv wi wy);

my $wordlist = shift @ARGV || '/usr/share/dict/words';

my $best_len = -1;
my @best_word;

open my $fh, '<', $wordlist;
while (my $word = <$fh>) {
    # normalize word
    $word =~ s/\s+$//;
    $word = lc $word;

    # check that each pair of letters is a state abbrev
    my $ok = 1;
    for (my $i = 0; $ok && $i < length($word); $i += 2) {
        $ok = defined $abbrevs{substr $word, $i, 2};
    }

    # is it the longest?
    if ($ok) {
        my $l = length($word);
        if ($l > $best_len) {
            $best_len = $l;
            @best_word = ($word);
        } elsif ($l == $best_len) {
            push @best_word, $word;
        }
    }
}

say "@best_word";

